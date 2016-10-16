
#include "PortIO.h"

using namespace StratifyIO;

QList<PortIO> PortIO::mPortList;

bool PortIO::reconnect(Link & link, int count, int delay){
    int i;

    for(i=0; i < count; i++){

        QThread::msleep(delay/2);

        refreshPortList(link);

        if ( lookupSerialNumber(link.serial_no().c_str()) != 0 ){
            //connect to last known serial number
            link.reinit(); //suppress any error messages
        }

        QThread::msleep(delay/2);

        if ( link.get_is_connected() ){
            return true;
        }

    }

    return false;
}


const PortIO * PortIO::lookupSerialNumber(const QString & serialNumber){
    for(int i=0; i < portList().count(); i++){
        if( portList().at(i).linkSerialPortInfo().serialNumber() == serialNumber ){
            return &(portList().at(i));
        }

    }
    return 0;
}


void PortIO::refreshPortList(Link & link){
    //use QSerialPort to get a list of known devices

    QList<QSerialPortInfo> list;
    list = QSerialPortInfo::availablePorts();
    mPortList.clear();
    int i=1;

    //filter ports that are not ports StratifyOS data link ports
    foreach(QSerialPortInfo info, list){
        qDebug() << "Device:" << i++;
        qDebug() << "\tMfg" << info.manufacturer();
        qDebug() << "\tPID" << info.productIdentifier();
        qDebug() << "\tVID" << info.vendorIdentifier();
        qDebug() << "\tName" << info.portName();
        qDebug() << "\tSystem Name" << info.systemLocation();
        qDebug() << "\tDescription" << info.description();
        qDebug() << "\tSerial Number" << info.serialNumber();

        //is the device a StratifyOS device
        if( info.description() == "StratifyOS" ){
            bool alreadyAdded = false;

            //is the serial number already accounted for
            foreach(PortIO item, mPortList){
                if( item.linkSerialPortInfo().serialNumber() == info.serialNumber() ){
                    alreadyAdded = true;
                    qDebug() << info.serialNumber() << "already added";
                }
            }

            if( !alreadyAdded ){
                //load sys attr
                sys_attr_t attr;
                if( loadSysAttr(link, info.systemLocation(), attr) == 0 ){
                    mPortList.append(PortIO(info,attr));
                    qDebug() << "Add" << QString(attr.name) << "on" << info.systemLocation();
                }
            }
        }
    }
}

int PortIO::loadSysAttr(Link & link, const QString & systemLocation, sys_attr_t & attr){
    memset(&attr, 0, sizeof(sys_attr_t));

    link.driver()->dev.handle = link.driver()->dev.open(systemLocation.toStdString().c_str(), 0);
    if( link.driver()->dev.handle != LINK_PHY_OPEN_ERROR ){

        if( link_isbootloader(link.driver()) ){
            strcpy(attr.name, "bootloader");
        } else {
            int sysFd;
            sysFd = link_open(link.driver(), "/dev/sys", LINK_O_RDWR);
            if( sysFd >= 0 ){
                if( link_ioctl(link.driver(), sysFd, I_SYS_GETATTR, &attr) == 0 ){
                    //now add the sys_attr to the string list
                    attr.name[NAME_MAX-1] = 0;  //make sure these are zero terminated
                    attr.version[7] = 0;
                }
                link_close(link.driver(), sysFd);
            } else {
                qDebug() << "Failed to open /dev/sys";
            }
        }
        qDebug() << "Close";
        link.driver()->dev.close(link.driver()->dev.handle);
        qDebug() << "Close complete";
        link.driver()->dev.handle = LINK_PHY_OPEN_ERROR;
    } else {
        qDebug() << "Failed to open" << systemLocation;
        return -1;
    }
    return 0;

}
