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

#include "DeviceManager.h"

#include <QDebug>

using namespace StratifyIO;

QList<DeviceListItem> DeviceManager::mDeviceList;

DeviceManager::DeviceManager(Link & link) : mLink(link){
    mUpdate = 0;
    mContext = 0;
    mUpdateEffective = 0;
    mContextEffective = 0;
}

DeviceManager::DeviceManager(Link & link, Link::update_callback_t update, void * context) : mLink(link){
    mUpdate = update;
    mUpdateEffective = mUpdate;
    mContext = context;
    mContextEffective = context;
}

const DeviceListItem * DeviceManager::lookupSerialNumber(const QString & serialNumber){
    for(int i=0; i < deviceList().count(); i++){
        if( deviceList().at(i).serialPortInfo().serialNumber() == serialNumber ){
            return &(deviceList().at(i));
        }

    }
    return 0;
}


void DeviceManager::refreshDeviceList(Link & link){
    //use QSerialPort to get a list of known devices

    QList<QSerialPortInfo> list;
    list = QSerialPortInfo::availablePorts();
    mDeviceList.clear();
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
            foreach(DeviceListItem item, mDeviceList){
                if( item.serialPortInfo().serialNumber() == info.serialNumber() ){
                    alreadyAdded = true;
                    qDebug() << info.serialNumber() << "already added";
                }
            }

            if( !alreadyAdded ){
                //load sys attr
                sys_attr_t attr;
                loadSysAttr(link, info.systemLocation(), attr);
                mDeviceList.append(DeviceListItem(info,attr));
                qDebug() << "Add" << QString(attr.name) << "on" << info.systemLocation();
            }
        }
    }
}

void DeviceManager::loadSysAttr(Link & link, const QString & systemLocation, sys_attr_t & attr){
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
    }

}


bool DeviceManager::updateProgress(int value, int max){
    if( mUpdateEffective ){
        return mUpdateEffective(mContextEffective, value, max);
    }
    return false;
}

bool DeviceManager::updateCummulativeCallback(void * context, int progress, int max){
    DeviceManager * object = (DeviceManager*)context;
    return object->updateCummulative(progress, max);

}

bool DeviceManager::updateCummulative(int progress, int max){
    max = 0; //suppress warning

    if( mCummulativeProgressCached > progress ){
        mCummulativeProgressCached = 0;
    }
    mCummulativeProgress += (progress - mCummulativeProgressCached);
    mCummulativeProgressCached = progress;

    if( mUpdate ){
        return mUpdate(mContext, mCummulativeProgress, mCummulativeMax);
    }
    return false;
}

void DeviceManager::setCummulativeMax(int value){
    mCummulativeProgress = 0;
    mCummulativeProgressCached = 0;
    mCummulativeMax = value;
    if( value == 0 ){
        mUpdateEffective = mUpdate;
        mContextEffective = mContext;
    } else {
        mUpdateEffective = updateCummulativeCallback;
        mContextEffective = this;
    }
}

void DeviceManager::resetCummulativeMax(){
    setCummulativeMax(0);
}

