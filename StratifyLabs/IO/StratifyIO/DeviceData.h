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

    void setSerialNo(const QString& value){ mSerialNo = value; }
    const QString & serialNo() const { return mSerialNo; }
    void setVersion(const QString& value){ mVersion = value; }
    const QString & version() const { return mVersion; }
    void setBootVersion(const QString& value){ mBootVersion = value; }
    const QString & bootVersion() const { return mBootVersion; }

private:
    QString mSerialNo;
    QString mVersion;
    QString mBootVersion;
    QStringList mTests;

};

}

#endif // DEVICE_H
