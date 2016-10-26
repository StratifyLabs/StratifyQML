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
#include "AppData.h"

using namespace StratifyData;

AppData::AppData(DataService * service) : Data(service){
   connect(dataService(), SIGNAL(changed()), this, SLOT(change()));
}

QString AppData::name() const {
    return json().value("name").toString();
}

QString AppData::github() const {
    return json().value("github").toString();
}


void AppData::change(){
    //new data is ready
    //QJsonObject object = dataService()->value();


    //mName = object.value("name").toString();
    //mGithub = object.value("github").toString();

}
