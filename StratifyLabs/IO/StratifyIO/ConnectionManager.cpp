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

#include "ConnectionManager.h"

using namespace StratifyIO;

ConnectionManager::ConnectionManager(Link & link) : DeviceManager(link)
{
    memset(&mSysAttr, 0, sizeof(mSysAttr));
}

int ConnectionManager::connectToDevice(const QString & serialNumber){
    QString sn;
    const DeviceListItem * item;
    sn = serialNumber;

    if( mLink.get_is_connected() ){
        disconnectFromDevice();
    }

    emit connectionChanged();

    item = DeviceManager::lookupSerialNumber(serialNumber);

    if( item == 0 ){
        return -1;
    }

    if( mLink.init(item->serialPortInfo().systemLocation().toStdString(), sn.toStdString()) < 0 ){
        return -1;
    }

    int fd;

    fd = mLink.open("/dev/sys", LINK_O_RDWR);
    if( fd >= 0 ){
        if( mLink.ioctl(fd, I_SYS_GETATTR, &mSysAttr) < 0 ){
            memset(&mSysAttr, 0, sizeof(mSysAttr));
        }
        mLink.close(fd);
    }

    emit connectionChanged();


    return 0;

}

int ConnectionManager::disconnectFromDevice(){
    if( mLink.get_is_connected() ){
        mLink.exit();
        memset(&mSysAttr, 0, sizeof(mSysAttr));
        emit connectionChanged();
    }
    return 0;
}
