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

#include "ListData.h"

#include <QDebug>

using namespace StratifyData;


ListData::ListData(DataService * service) : Data(service){
    mIsPostPending = false;
}

int ListData::count(){
    return json().keys().count();
}

QJsonObject ListData::at(int i){
    return json().value(json().keys().at(i)).toObject();
}

void ListData::setPostName(const QString & name){
    mIsPostPending = false;

    if( name.isEmpty() ){
        return;
    }
    qDebug() << Q_FUNC_INFO << "Set post name" << name;
    QJsonDocument doc = QJsonDocument::fromJson(name.toUtf8());
    mJson.insert(doc.object().value("name").toString(), mPostObject);
    mPostObject = QJsonObject();

}


bool ListData::append(const Data * data){
    return append(data->json());
}

bool ListData::append(const QJsonObject & object){
    mPostObject = object;
    QJsonDocument doc;
    doc.setObject(object);
    return append(doc.toJson());
}

bool ListData::append(const QString & value){
    if( mIsPostPending ){
        return false;
    }
    mIsPostPending = true;
    QJsonDocument doc = QJsonDocument::fromJson(value.toUtf8());
    mPostObject = doc.object();
    postValue(value);
    return true;
}
