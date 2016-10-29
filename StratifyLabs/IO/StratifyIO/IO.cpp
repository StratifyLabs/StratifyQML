/*
Copyright 2016 Tyler Gilbert

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

#include "IO.h"

#include <QByteArray>
#include <QFile>
#include <stfy/sys.hpp>
#include <QDebug>

using namespace StratifyIO;


IO::IO(Link & link) : mLink(link){}


bool IO::updateProgressCallback(void * context, int progress, int max){
    IO* object = (IO*)context;
    return object->updateProgress(progress, max);
}

bool IO::updateProgress(int value, int max){
    emit progressChanged(value, max);
    return false;
}

bool IO::updateCummulativeCallback(void * context, int progress, int max){
    IO * object = (IO*)context;
    return object->updateCummulative(progress, max);

}

bool IO::updateCummulative(int progress, int max){
    max = 0; //suppress warning

    if( mCummulativeProgressCached > progress ){
        mCummulativeProgressCached = 0;
    }
    mCummulativeProgress += (progress - mCummulativeProgressCached);
    mCummulativeProgressCached = progress;

    emit progressChanged(mCummulativeProgress, mCummulativeMax);

    return false;
}

void IO::setCummulativeMax(int value){
    mCummulativeProgress = 0;
    mCummulativeProgressCached = 0;
    mCummulativeMax = value;
}

void IO::resetCummulativeMax(){
    setCummulativeMax(0);
}

int IO::copyFileToDevice(QString source, QString dest, link_mode_t mode){
    return copyFileToDevice(source, dest, mode, updateProgressCallback);
}


int IO::copyFileToDeviceCummulative(QString source, QString dest, link_mode_t mode){
    return copyFileToDevice(source, dest, mode, updateCummulativeCallback);
}

int IO::copyFileFromDevice(QString source, QString dest, link_mode_t mode){
    return copyFileFromDevice(source, dest, mode, updateProgressCallback);
}

int IO::copyFileFromDeviceCummulative(QString source, QString dest, link_mode_t mode){
    return copyFileFromDevice(source, dest, mode, updateCummulativeCallback);
}

int IO::copyFileFromDevice(QString source,
             QString dest,
             link_mode_t mode,
             bool (*update)(void*,int,int)
             ){
    int ret;

    ret = mLink.copy_file_from_device(source.toStdString(),
                                       dest.toStdString(),
                                       mode,
                                       update,
                                       this);

    if( ret < 0 ){
        emit statusChanged(ERROR, "Failed to upload file " + source + ": " +
                           QString(mLink.error_message().c_str()));
    }

    emit updateProgress(0,0);


    return ret;
}

int IO::copyFileToDevice(QString source,
             QString dest,
             link_mode_t mode,
             bool (*update)(void*,int,int)
             ){
    int ret;

    emit statusChanged(IO::INFO, "Copying " + source + " to " + dest);

    if( dest.startsWith("/app/flash") ){
        //need to install in flash memory
        QByteArray buffer;
        QFile file;
        QFileInfo info;

        file.setFileName(source);
        if( file.open(QFile::ReadOnly) == false ){
            emit statusChanged(ERROR, "Failed to open: " + source);
            return -1;
        }

        buffer = file.readAll();
        info.setFile(dest);

        emit statusChanged(DEBUG, QString(Q_FUNC_INFO) + " copy " + dest + " to flash");
        ret = Appfs::create(
                    info.fileName().toStdString().c_str(),
                    buffer.data(),
                    buffer.size(),
                    "/app",
                    update,
                    this,
                    mLink.driver()
                      );
    } else {

    ret = mLink.copy_file_to_device(source.toStdString(),
                                     dest.toStdString(),
                                     mode,
                                     updateProgressCallback,
                                     this);
    }

    emit updateProgress(0,0);

    if( ret < 0 ){
        emit statusChanged(ERROR, "Failed to copy " +
                           source + " to " + dest + ":"
                           + QString(mLink.error_message().c_str()));
    }
    return ret;
}

