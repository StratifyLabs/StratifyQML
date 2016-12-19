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

#include <QJsonObject>
#include <QFile>
#include <QDebug>

#include "AppData.h"

using namespace StratifyData;

AppData::AppData(DataService * service) : Data(service){}

AppData::AppData(const QJsonObject & object, DataService * service) : Data(service) {
    mJson = object;
}


bool AppData::validate(){
    //make sure the object has data populated appropriately
    return false;
}

int AppData::ram() const {
    return json().value( AppData::ramKey() ).toInt();
}


void AppData::setRam(int value){
    mJson[ AppData::ramKey() ] = value;
}

