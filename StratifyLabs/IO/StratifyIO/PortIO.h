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
    static bool reconnect(Link & link, int count = 10, int delay = 3000);

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
