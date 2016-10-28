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

#ifndef CONNECTIONMANAGER_H
#define CONNECTIONMANAGER_H

#include "IO.h"
#include "TraceEvent.h"

namespace StratifyIO {

class ConnectionIO : public IO
{
    Q_OBJECT
public:
    ConnectionIO(Link & link);

    int connectToDevice(const QString & serialNumber);
    int disconnectFromDevice();

    bool isBootloader() const { return mLink.is_bootloader(); }
    bool isConnected() const { return mLink.get_is_connected(); }

    QString name() const { return QString(mLink.sys_attr().name); }
    QString signature() const { return QString::number(mLink.sys_attr().signature, 16); }
    QString version() const { return QString(mLink.sys_attr().sys_version); }
    QString kernelVersion() const { return QString(mLink.sys_attr().version); }
    int sysFlags() const { return mLink.sys_attr().flags; }

    //Monitor the connection on a separate thread
    static void monitorWork(void * object){ ((ConnectionIO*)object)->monitorWorker(); }
    void monitorWorker();

    //Notifications
    static void listenForNotificationsWork(void * object){ ((ConnectionIO*)object)->listenForNotificationsWorker(); }
    void listenForNotificationsWorker();
    void stopNotifications(){ mIsStopNotifications = true; }
    bool isNotificationsStopped() const { return mIsNotificationsStopped; }


signals:
    void deviceAccessed(const QString & device, bool read, int nbyte);
    void fileAccessed(const QString & file, bool read, int nbyte);
    void traceEventReceived(const QJsonObject & object);

private:
    volatile bool mIsStopNotifications;
    volatile bool mIsNotificationsStopped;
    volatile bool mIsStopMonitor;
    volatile bool mIsMonitorStopped;

};

}

#endif // CONNECTIONMANAGER_H
