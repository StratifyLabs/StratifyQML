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

#include "AppIO.h"

#include <QDebug>
#include <QFile>

using namespace StratifyIO;

AppIO::AppIO(Link & link) : IO(link){}


int AppIO::kill(const QString & name){
    int pid;

    pid = mLink.get_pid(name.toStdString());
    if( pid < 0 ){
        //not currently running
        return 0;
    }

    mLink.kill_pid(pid, LINK_SIGKILL);
    return 0;
}


int AppIO::prepareBinary(const QString & sourcePath, const QString & name, bool startup, bool ram, int ramSize){
    if( mLink.update_binary_install_options(sourcePath.toStdString().c_str(), name.toStdString().c_str(), startup, ram, ramSize) < 0 ){
        emit statusChanged(ERROR, "Failed to prepare binary:" + QString(mLink.error_message().c_str()));
        return -1;
    }
    return 0;
}


int AppIO::installApp(const QString & sourcePath, const QString & installPath, const QString & name){

    QString unlinkPath;
    //delete the app if it currently is in the app system
    unlinkPath = "/app/flash/" + name;

    qDebug() << "unlink" << unlinkPath;

    while( mLink.unlink(unlinkPath.toStdString()) >= 0 ){
        //delete all versions
        qDebug() << "unlinked" << unlinkPath;
        emit statusChanged(DEBUG, QString(Q_FUNC_INFO) + ": unlinked " + unlinkPath);
    }

    unlinkPath = "/app/ram/" + name;
    while( mLink.unlink(unlinkPath.toStdString()) >= 0 ){
        //delete all versions
        emit statusChanged(DEBUG, QString(Q_FUNC_INFO) + ": unlinked " + unlinkPath);

    }

    qDebug() << "Install" << sourcePath << "at" << installPath << "as" << name;
    if( mLink.install_app(sourcePath.toStdString(),
                           installPath.toStdString(),
                           name.toStdString(),
                           updateProgressCallback, this) < 0 ){
        emit statusChanged(ERROR, "Failed to install " + name + ": " + mLink.error_message().c_str());
        return -1;
    }

    emit statusChanged(INFO, "Successfully installed " + sourcePath + " to " + installPath);

    return 0;
}

int AppIO::runApp(const QString & name){
    QString appPath;
    //look for the full path (flash or RAM)

    if( mLink.get_is_connected() == false ){
        emit statusChanged(ERROR, "Can't run " + name + ": not connected");
        return -1;
    }


    if( mLink.get_pid(name.toStdString()) >= 0 ){
        emit statusChanged(ERROR, "Can't run " + name + ": already running");
        return 1;
    }


    appPath = "/app/flash/" + name;
    if( mLink.run_app(appPath.toStdString()) < 0 ){
        appPath = "/app/ram/" + name;
        if( mLink.run_app(appPath.toStdString()) < 0 ){
            emit statusChanged(ERROR, "Failed to run app " + QString(mLink.error_message().c_str()));
            return -1;
        }
    }

    emit statusChanged(INFO, "Successfully started " + name);

    return 0;
}


int AppIO::uninstallApp(const QString & path, const QString & name){

    emit statusChanged(DEBUG, QString(Q_FUNC_INFO) + ": Uninstalled " + path + "/" + name);

    if( mLink.unlink("/app/flash/" + name.toStdString()) == 0 ){
        emit statusChanged(INFO, "Successfully uninstalled " + name);

        return 0;
    }

    if( mLink.unlink("/app/ram/" + name.toStdString()) == 0 ){
        emit statusChanged(INFO, "Successfully uninstalled " + name);
        return 0;
    }

    if( mLink.unlink(QString(path + "/" + name).toStdString()) == 0 ){
        emit statusChanged(INFO, "Successfully uninstalled " + name);
        return 0;
    }

    emit statusChanged(ERROR, "Failed to uninstall " + path + "/" + name + ": " + mLink.error_message().c_str());
    return -1;

}

int AppIO::installFiles(const QString & settingsPath){

    qDebug() << "Settings Path" << settingsPath;
    //settingsPath is a JSON file which says which files are to be installed

    return 0;
}
