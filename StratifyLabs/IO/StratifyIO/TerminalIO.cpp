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

#include "TerminalIO.h"

#include <iface/dev/fifo.h>
#include <stfy/hal.hpp>

using namespace StratifyIO;


TerminalIO::TerminalIO(Link & link) : IO(link){
    mInFd = -1;
    mOutFd = -1;
}


int TerminalIO::open(){
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
        emit statusChanged(ERROR, "Failed to open system device: " + QString(mLink.error_message().c_str()));
        return -1;
    }

    if( sysDevice.ioctl(I_SYS_GETATTR, &attr) < 0 ){
        emit statusChanged(ERROR, "Failed to get system attributes: " + QString(mLink.error_message().c_str()));
        sysDevice.close();
        return -1;
    }

    sysDevice.close();

    if( attr.flags & SYS_FLAGS_STDIO_VCP ){
        emit statusChanged(WARNING, "SYS_FLAGS_STDIO_VCP flag is deprecated");
    } else if( attr.flags & SYS_FLAGS_STDIO_FIFO ) {

        tmpIn = QString(attr.stdin_name);
        tmpOut = QString(attr.stdout_name);

        if ( mLink.is_bootloader() ){
            emit statusChanged(ERROR, "Device is a bootloader");
            return -1;
        }

        mInFd = mLink.open(tmpOut.toStdString(), LINK_O_RDWR | LINK_O_NONBLOCK);
        if( mInFd < 0 ){
            emit statusChanged(ERROR, "Failed to open /dev/" + tmpIn + ": " + mLink.error_message().c_str());
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
                emit statusChanged(ERROR, "Failed to open /dev/" + tmpOut + ": " + mLink.error_message().c_str());
                mLink.close(mInFd);
                mInFd = -1;
                mOutFd = -1;
                return -1;
            }
        }

        mLink.ioctl(mInFd, I_FIFO_SETWRITEBLOCK, (void*)1);
    }


    return 0;
}

int TerminalIO::close(){

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

QByteArray TerminalIO::read(){
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

int TerminalIO::write(const QByteArray & data){
    if( mLink.get_is_connected() == false ){
        return -1;
    }

    return mLink.write(mOutFd, data.data(), data.size());
}

