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

#include <QStringList>
#include "DeviceManager.h"

namespace StratifyIO {

class ConnectionManager : public DeviceManager
{
    Q_OBJECT
public:
    ConnectionManager(Link & link);

    int connectToDevice(const QString & serialNumber);
    int disconnectFromDevice();

    bool isBootloader() const { return mLink.is_bootloader(); }
    bool isConnected() const { return mLink.get_is_connected(); }

    QString name() const { return QString(mSysAttr.name); }
    QString signature() const { return QString::number(mSysAttr.signature, 16); }
    QString version() const { return QString(mSysAttr.sys_version); }
    QString kernelVersion() const { return QString(mSysAttr.version); }
    int sysFlags() const { return mSysAttr.flags; }

signals:
    void connectionChanged();

private:

    sys_attr_t mSysAttr;

};

}

#endif // CONNECTIONMANAGER_H
