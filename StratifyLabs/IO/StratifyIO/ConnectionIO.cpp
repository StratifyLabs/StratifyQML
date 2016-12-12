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

#include <StratifyData/Worker.h>

#include "PortIO.h"
#include "ConnectionIO.h"


using namespace Stratify;
using namespace StratifyIO;

ConnectionIO::ConnectionIO(Link & link, QMutex * mutex) : IO(link){
    mMutex = mutex;
}

int ConnectionIO::connectToDevice(const QString & serialNumber){
    QString sn;
    const PortIO * item;
    sn = serialNumber;

    if( mLink.get_is_connected() ){
        disconnectFromDevice();
    }

    emit connectionChanged();

    PortIO::refreshPortList(mLink);

    item = PortIO::lookupSerialNumber(serialNumber);

    if( item == 0 ){
        emit statusChanged(WARNING, "Failed to connect: device is not connected");
        return -1;
    }

    emit statusChanged(DEBUG, QString(Q_FUNC_INFO) + " Connecting to link: " +
                       item->linkPath() +
                       " notify: " + item->notifyPath());

    if( mLink.init(item->linkPath().toStdString(),
                   sn.toStdString(),
                   item->notifyPath().toStdString()
                   ) < 0 ){
        emit statusChanged(IO::ERROR, "Failed to connect to " + sn);
        return -1;
    }

    if( mLink.is_notify() ){
        Worker::startWork(listenForNotificationsWork, this);
        emit statusChanged(DEBUG, QString(Q_FUNC_INFO) + ": Notify supported on link");
        emit statusChanged(DEBUG, QString(Q_FUNC_INFO) + ": Handles " +
                           QString::number((quint64)mLink.driver()->dev.handle, 16) + " " +
                           QString::number((quint64)mLink.driver()->dev.notify_handle, 16)
                           );
    } else {
        mIsNotificationsStopped = true;
        emit statusChanged(DEBUG, QString(Q_FUNC_INFO) + ": Notify NOT supported on link");
    }

    if( mLink.is_bootloader() == false ){
        sys_attr_t attr = mLink.sys_attr();
        PortIO::setSysAttrCache(serialNumber, attr);
    }

    emit connectionChanged();
    emit statusChanged(INFO, "Successfully connected to " + sn);
    Worker::startWork(monitorWork, this);


    return 0;

}

int ConnectionIO::disconnectFromDevice(){
    int count = 0;
    mIsStopNotifications = true;
    mIsStopMonitor = true;

    qDebug() << Q_FUNC_INFO << "Stop Connection threads";

    //wait for the threads to release the device
    while( ((mIsNotificationsStopped == false) || (mIsMonitorStopped == false)) && (count++ < 100) ){
        QThread::yieldCurrentThread();
        QThread::msleep(10);
    }

    qDebug() << Q_FUNC_INFO << "Connection threads stopped";

    if( mLink.get_is_connected() ){
        mLink.exit();
        emit statusChanged(IO::INFO, "Successfully disconnected from " +
                           QString(mLink.serial_no().c_str()));
    }

    emit connectionChanged();

    return 0;
}

void ConnectionIO::listenForNotificationsWorker(){

    const int bufferSize = 512;
    char buffer[bufferSize];
    char * bufPtr;
    QString str;
    TraceEvent event;
    int ret;
    int bytesProcessed;

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

    emit statusChanged(DEBUG, QString(Q_FUNC_INFO) + ": listening to notify port");
    link_notify_dev_t * notifyDev;
    link_notify_file_t * notifyFile;
    link_notify_posix_trace_event_t * notifyTraceEvent;

    mIsNotificationsStopped = false;
    mIsStopNotifications = false; //must be changed in another thread
    while( mIsStopNotifications == false ){
        memset(buffer, 0, bufferSize);
        if( mMutex != 0 ){
            mMutex->lock();
        }

        if( mLink.get_is_connected() == false ){
            qDebug() << Q_FUNC_INFO << "Notify listener isn't connected";
            mIsStopNotifications = true;
        } else {
            ret = mLink.read_notify(buffer, bufferSize);
        }

        if( mMutex != 0 ){
            mMutex->unlock();
        }

        if( ret > 0 ){
            bytesProcessed = 0;
            while(bytesProcessed < ret){
                bufPtr = &(buffer[bytesProcessed]);
                //parse notification and emit signal
                id = (u32*)bufPtr;
                isRead = false;
                switch(*id){
                case LINK_NOTIFY_ID_DEVICE_READ:
                    isRead = true;
                case LINK_NOTIFY_ID_DEVICE_WRITE:
                    if( (ret - bytesProcessed) >= (int)sizeof(link_notify_dev_t)){
                        notifyDev = (link_notify_dev_t*)bufPtr;
                        str = notifyDev->name;
                        emit deviceAccessed(str, isRead, notifyDev->nbyte);
                        bytesProcessed += sizeof(link_notify_dev_t);
                    } else {
                        bytesProcessed = ret;
                    }
                    break;
                case LINK_NOTIFY_ID_FILE_READ:
                    isRead = true;
                case LINK_NOTIFY_ID_FILE_WRITE:
                    if( (ret - bytesProcessed) >= (int)sizeof(link_notify_file_t)){
                        notifyFile = (link_notify_file_t*)bufPtr;
                        str = notifyFile->name;
                        emit fileAccessed(str, isRead, notifyFile->nbyte);
                        bytesProcessed += sizeof(link_notify_file_t);
                    } else {
                        bytesProcessed = ret;
                    }
                    break;
                case LINK_NOTIFY_ID_POSIX_TRACE_EVENT:
                    if( (ret - bytesProcessed) >= (int)sizeof(link_notify_posix_trace_event_t)){
                        notifyTraceEvent = (link_notify_posix_trace_event_t*)bufPtr;
                        event.setInfo(notifyTraceEvent->info);
                        emit traceEventReceived(event.toJson());
                        bytesProcessed += sizeof(link_notify_posix_trace_event_t);
                    } else {
                        bytesProcessed = ret;
                    }
                    break;
                default:
                    qDebug() << "Not recognized";
                    bytesProcessed = ret;
                    break;
                }
            }
        }
        QThread::msleep(50);
    }

    mIsNotificationsStopped = true;
    emit statusChanged(DEBUG, QString(Q_FUNC_INFO) + ": stopped listening");

}

void ConnectionIO::monitorWorker(){
    mIsMonitorStopped = false;
    mIsStopMonitor = false;
    bool isConnected = true;
    while( mIsStopMonitor == false ){
        //check the IO list to see if the device is still present

        if( mMutex != 0 ){
            mMutex->lock();
        }
        isConnected = mLink.get_is_connected();
        if( mMutex != 0 ){
            mMutex->unlock();
        }
        if( isConnected == false ){
            break;
        }
        QThread::msleep(500);
    }

    qDebug() << Q_FUNC_INFO << "Monitor stopped";
    mIsMonitorStopped = true;

    if( mIsStopMonitor == false ){
        emit statusChanged(INFO, QString(mLink.serial_no().c_str()) + " disconnected");
    }
    emit connectionChanged();
}



