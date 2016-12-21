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

#include "KernelData.h"


using namespace StratifyData;

KernelData::KernelData(DataService * service) : Data(service){}

KernelData::KernelData(const QJsonObject & object, DataService * service) : Data(service) {
    mJson = object;
}


QStringList KernelData::deviceList() const {
    return json().value( KernelData::deviceListKey() ).toObject().keys();

}


void KernelData::setAssets(const QJsonObject & assets){
    mJson.insert(assetsKey(), assets);
}


void KernelData::setBootSuffix(const QString & value){
    mJson[ bootSuffixKey() ] = value;
}

QString KernelData::bootSuffix() const{
    return mJson.value(bootSuffixKey()).toString();
}
