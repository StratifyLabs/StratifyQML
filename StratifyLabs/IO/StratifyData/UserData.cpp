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

#include "UserData.h"

using namespace StratifyData;

UserData::UserData(DataService * service) : Data(service){}

UserData::UserData(const QJsonObject & object, DataService * service) : Data(service){
    mJson = object;
}

bool UserData::validate(){
     return true;
 }

QString UserData::name() const {
    return json().value("name").toString();

}

QString UserData::email() const {
    return json().value("email").toString();
}

QString UserData::handle() const {
    return json().value("handle").toString();
}

QString UserData::uid() const {
    return json().value("uid").toString();
}

void UserData::setName(const QString & value){
    mJson["name"] = value;
}

void UserData::setEmail(const QString & value){
    mJson["email"] = value;
}


void UserData::setHandle(const QString & value){
    mJson["handle"] = value;
}

void UserData::setUid(const QString & value){
    mJson["uid"] = value;
}

