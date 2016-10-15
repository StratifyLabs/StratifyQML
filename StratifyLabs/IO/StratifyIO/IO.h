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

#ifndef DEVICEMANAGER_H
#define DEVICEMANAGER_H

#include <QObject>
#include <QString>
#include <QList>
#include <QStringList>
#include <QtSerialPort/QtSerialPort>
#include <Link.h>

#include "StratifyObject.h"

namespace StratifyIO {

class DeviceListItem {
public:
    DeviceListItem(){}
    DeviceListItem(const QSerialPortInfo & info, const sys_attr_t & attr){
        mSerialPortInfo = info;
        memcpy(&mSysAttr, &attr, sizeof(sys_attr_t));
    }

    const QSerialPortInfo & serialPortInfo() const { return mSerialPortInfo; }
    QString name() const { return QString(mSysAttr.name); }
    QString version() const { return QString(mSysAttr.sys_version); }
    QString kernelVersion() const { return QString(mSysAttr.version); }

private:
    QSerialPortInfo mSerialPortInfo;
    sys_attr_t mSysAttr;
};

class IO: public StratifyObject
{
    Q_OBJECT
public:
    IO(Link & link);
    const QString & error() const { return mError; }

    static void refreshDeviceList(Link & link);
    static const QList<DeviceListItem> & deviceList() { return mDeviceList; }
    static const DeviceListItem * lookupSerialNumber(const QString & serialNumber);

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

    static int loadSysAttr(Link & link, const QString & systemLocation, sys_attr_t & attr);

    static bool updateProgressCallback(void * context, int progress, int max);
    bool updateProgress(int value, int max);
    Link & mLink;

    static bool updateCummulativeCallback(void*context, int progress, int max);
    bool updateCummulative(int progress, int max);
    int mCummulativeProgress;
    int mCummulativeProgressCached;
    int mCummulativeMax;

    QString mError;
    static QList<DeviceListItem> mDeviceList;

};

}

#endif // DEVICEMANAGER_H
