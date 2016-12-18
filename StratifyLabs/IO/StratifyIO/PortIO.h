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


#ifndef PORTIO_H
#define PORTIO_H

#include <QJsonObject>
#include <QJsonArray>
#include <QObject>
#include <QString>
#include <QList>
#include <QtSerialPort/QtSerialPort>
#include <iface/dev/sys.h>
#include <Link.h>

namespace StratifyIO {

class PortIO {
public:

    static void init();
    static void exit();

    static void refreshPortList(Link & link);
    static const QList<PortIO> & portList() { return mPortList; }
    static const PortIO * lookupSerialNumber(const QString & serialNumber);
    static bool reconnect(Link & link, int count = 10, int delay = 1000);

    PortIO(){
        mIsNotifyPortValid = false;
    }

    PortIO(const QSerialPortInfo & info, const sys_attr_t & attr){
        mLinkSerialPortInfo = info;
        memcpy(&mSysAttr, &attr, sizeof(sys_attr_t));
        mIsNotifyPortValid = false;
        mIsBootloader = false;
    }

    const QSerialPortInfo & linkSerialPortInfo() const { return mLinkSerialPortInfo; }
    const QSerialPortInfo & notifySerialPortInfo() const { return mNotifySerialPortInfo; }
    QString name() const { return QString(mSysAttr.name); }
    QString version() const { return QString(mSysAttr.sys_version); }
    QString kernelVersion() const { return QString(mSysAttr.version); }
    sys_attr_t sysAttr() const { return mSysAttr; }
    bool isNotifyPortValid() const { return mIsNotifyPortValid; }

    QString linkPath() const { return mLinkSerialPortInfo.systemLocation(); }
    QString notifyPath() const {
        if( mIsNotifyPortValid ){
            return mNotifySerialPortInfo.systemLocation();
        } else {
            return QString();
        }
    }

    static void setSysAttrCache(const QString & serialNumber, sys_attr_t & attr);

private:

    static QJsonObject mPortSettings;


    static bool getSysAttrCache(const QString & serialNumber, sys_attr_t & attr);

    static int loadSysAttr(Link & link, const QString & systemLocation, sys_attr_t & attr);
    static QList<PortIO> mPortList;

    bool mIsLinkPortValid;
    bool mIsNotifyPortValid;
    bool mIsBootloader;
    int mDevicePortCount;
    QSerialPortInfo mLinkSerialPortInfo; //port for link protocol
    QSerialPortInfo mNotifySerialPortInfo; //port to receive notifications
    sys_attr_t mSysAttr;




};

}

#endif // PORTIO_H
