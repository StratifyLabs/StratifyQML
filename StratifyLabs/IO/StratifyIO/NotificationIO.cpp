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

#include "NotificationIO.h"

#include <QThread>
#include <QDebug>

using namespace StratifyIO;


NotificationIO::NotificationIO(Link & link) : IO(link){}

#include <iface/link.h>

void NotificationIO::listen(){

    char buffer[128];
    QString str;

    u32 * id;
    bool isRead;

    if( mLink.get_is_connected() == false ){
        //Device is not connected
        qDebug() << "Device is not connected";
        return;
    }

    if( mLink.is_notify() == false ){
        //there won't be any notifications
        qDebug() << "Device is not able to receive notifications";
        return;
    }

    link_notify_dev_t * notifyDev;
    link_notify_file_write_t * notifyFile;
    //link_notify_posix_trace_event_t * notifyTrace;

    mStop = false; //must be changed in another thread
    while( mStop == false ){
        QThread::msleep(50);
        if( mLink.read_notify(buffer, 128) > 0 ){
            //parse notification and emit signal
            id = (u32*)buffer;
            isRead = false;
            switch(*id){
            case LINK_NOTIFY_ID_DEVICE_READ:
                isRead = true;
            case LINK_NOTIFY_ID_DEVICE_WRITE:
                notifyDev = (link_notify_dev_t*)buffer;
                str = notifyDev->name;
                qDebug() << "Device access" << str;
                emit deviceAccess(str, isRead, notifyDev->nbyte);
                break;
            case LINK_NOTIFY_ID_FILE_READ:
                isRead = true;
            case LINK_NOTIFY_ID_FILE_WRITE:
                notifyFile = (link_notify_file_write_t*)buffer;
                str = notifyFile->name;
                emit fileAccess(str, isRead, notifyFile->nbyte);
                break;
            case LINK_NOTIFY_ID_POSIX_TRACE_EVENT:
                //emit notifyTrace();
                break;

            }
        }
    }

}
