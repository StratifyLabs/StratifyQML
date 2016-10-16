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

#ifndef STRATIFY_IO_H
#define STRATIFY_IO_H

#include <QObject>
#include <QString>
#include <QList>
#include <QStringList>
#include <QtSerialPort/QtSerialPort>
#include <Link.h>

#include "StratifyObject.h"

namespace StratifyIO {

class IO: public StratifyObject
{
    Q_OBJECT
public:
    IO(Link & link);

    int copyFileToDevice(QString source, QString dest, link_mode_t mode = 0666){
        return mLink.copy_file_to_device(source.toStdString(),
                                         dest.toStdString(),
                                         mode,
                                         updateProgressCallback,
                                         this);
    }

    int copyFileToDeviceCummulative(QString source, QString dest, link_mode_t mode = 0666){
        return mLink.copy_file_to_device(source.toStdString(),
                                         dest.toStdString(),
                                         mode,
                                         updateCummulativeCallback,
                                         this);
    }


    void setCummulativeMax(int value);
    void resetCummulativeMax();

protected:


    static bool updateProgressCallback(void * context, int progress, int max);
    bool updateProgress(int value, int max);
    Link & mLink;

    static bool updateCummulativeCallback(void*context, int progress, int max);
    bool updateCummulative(int progress, int max);
    int mCummulativeProgress;
    int mCummulativeProgressCached;
    int mCummulativeMax;

};

}

#endif // STRATIFY_IO_H
