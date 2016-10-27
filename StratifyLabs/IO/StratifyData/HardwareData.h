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

#ifndef HARDWARE_H
#define HARDWARE_H


#include <QString>
#include "Data.h"
#include "DeviceData.h"

namespace StratifyData {

class HardwareData : public Data
{
public:
    HardwareData();


    QString version() const;
    quint32 hardwareId() const;
    QString description() const;
    QStringList deviceList() const;
    QString name() const;
    DeviceData device(const QString & serialNo);


};

}

#endif // HARDWARE_H
