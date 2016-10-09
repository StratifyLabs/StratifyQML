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

#include "TerminalManager.h"

#include <iface/dev/fifo.h>
#include <stfy/hal.hpp>

using namespace StratifyIO;


TerminalManager::TerminalManager(Link & link) : DeviceManager(link){
    mInFd = -1;
    mOutFd = -1;
}


int TerminalManager::open(){
    sys_attr_t attr;
    QString tmpIn;
    QString tmpOut;

    Dev sysDevice;

    if( mLink.get_is_connected() == false ){
        mInFd = -1;
        mOutFd = -1;
        return -1;
    }

    sysDevice.set_driver(mLink.driver());

    if( sysDevice.open("/dev/sys", Dev::READWRITE) < 0 ){
        mError = "Failed to open system device";
        return -1;
    }

    if( sysDevice.ioctl(I_SYS_GETATTR, &attr) < 0 ){
        sysDevice.close();
        mError = "Failed to get system attributes";
        return -1;
    }

    sysDevice.close();

    if( attr.flags & SYS_FLAGS_STDIO_VCP ){
        mError = "VCP stdio is not yet supported";
        return -1;
    } else if( attr.flags & SYS_FLAGS_STDIO_FIFO ) {

        tmpIn = QString(attr.stdin_name);
        tmpOut = QString(attr.stdout_name);

        if ( mLink.is_bootloader() ){
            mError = "Device is a bootloader";
            return -1;
        }

        mInFd = mLink.open(tmpOut.toStdString(), LINK_O_RDWR | LINK_O_NONBLOCK);
        if( mInFd < 0 ){
            mError = "Failed to open /dev/" + tmpIn;
            mInFd = -1;
            mOutFd = -1;
            return -1;
        }

        if( tmpIn == tmpOut ){
            //if the device is the same, use the same descriptor
            mOutFd = mInFd;
        } else {
            mOutFd = mLink.open(tmpIn.toStdString(), LINK_O_RDWR | LINK_O_NONBLOCK);
            if( mOutFd < 0 ){
                mLink.close(mInFd);
                mInFd = -1;
                mOutFd = -1;
                mError = "Failed to open /dev/" + tmpOut;
                return -1;
            }
        }

        mLink.ioctl(mInFd, I_FIFO_SETWRITEBLOCK, (void*)1);
    }


    return 0;
}

int TerminalManager::close(){

    if( mInFd >= 0 ){
        if( mLink.get_is_connected() ){
            mLink.ioctl(mInFd, I_FIFO_SETWRITEBLOCK, (void*)0);
            mLink.close(mInFd);
        }
        mInFd = -1;
    }

    if( mOutFd >= 0 ){
        if( mLink.get_is_connected() ){
            mLink.close(mOutFd);
        }
        mOutFd = -1;
    }


    return 0;

}

QByteArray TerminalManager::read(){
    char buffer[1024];
    int ret;
    QByteArray data;
    int totalRead = 0;

    data.clear();

    if( mLink.get_is_connected() == false ){
        close();
        return data;
    }

    do {
        ret = mLink.read(mInFd, buffer, 1024);
        if( ret > 0 ){
            totalRead += ret;
            data.append(buffer, ret);
        }
    } while( (ret > 0) && (totalRead < 4096) );

    return data;
}

int TerminalManager::write(const QByteArray & data){
    if( mLink.get_is_connected() == false ){
        close();
        return -1;
    }

    return mLink.write(mOutFd, data.data(), data.size());
}

