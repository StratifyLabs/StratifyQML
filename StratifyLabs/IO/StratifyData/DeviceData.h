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

#ifndef DEVICE_H
#define DEVICE_H

#include <QString>
#include <QStringList>

#include "Data.h"

namespace StratifyData {

class DeviceData : public Data
{
public:
    DeviceData();
    DeviceData(const QJsonObject & object);

    void setSerialNo(const QString & value);
    QString serialNo() const;
    void setVersion(const QString & value);
    QString version() const;
    void setKernelVersion(const QString & value);
    QString kernelVersion() const;
    void setBootVersion(const QString & value);
    QString bootVersion() const;
    QStringList testList() const;

private:



};

}

#endif // DEVICE_H
