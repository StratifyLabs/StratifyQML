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

QString AppData::publisher() const {
    return json().value("publisher").toString();
}

QString AppData::version() const {
    return json().value("version").toString();
}

QString AppData::name() const {
    return json().value("name").toString();
}

QString AppData::github() const {
    return json().value("github").toString();
}

QString AppData::description() const {
    return json().value("description").toString();
}

int AppData::description() const {
    return json().value("ram").toInt();
}

QString AppData::tags() const {
    return json().value("tags").toString();
}

QStringList AppData::buildList() const {
    return json().value("buildlist").toObject().keys();
}

bool AppData::getBuild(const QString & key, const QString & filename){

    QFile file;

    file.setFileName(filename);

    if( file.open(QFile::WriteOnly) == false ){
        emit statusChanged(ERROR, "Failed to create file: " + filename);
        return false;
    }

    QByteArray data;

    data = QByteArray::fromBase64(json().value("buildlist").toObject().value(key).toString().toStdString().c_str());

    file.write(data);
    file.close();

    return true;
}

void AppData::setVersion(const QString & value){
    mJson["version"] = value;
}

void AppData::setName(const QString & value){
    mJson["name"] = value;
}

void AppData::setGithub(const QString & value){
    mJson["github"] = value;
}

void AppData::setDescription(const QString & value){
    mJson["description"] = value;

}

void AppData::setTags(const QString & value){
    mJson["tags"] = value;
}

void AppData::setPublisher(const QString & value){
    mJson["publisher"] = value;
}

void AppData::setRam(int value){
    mJson["ram"] = value;
}



void AppData::setBuild(const QString & key, const QString & filename){
    QString value;

    QFile file;
    QByteArray data;

    file.setFileName(filename);

    if( file.open(QFile::ReadOnly) == false ){
        qDebug() << "Failed to open file name";
        emit statusChanged(ERROR, "Failed to open file: " + filename);
        return;
    }

    data = file.readAll();
    file.close();

    if( mJson.value("buildlist").toObject().isEmpty() ){
        mJson.insert("buildlist", QJsonValue(QJsonObject()));
    }

    QJsonObject buildlistObject = mJson.value("buildlist").toObject();
    buildlistObject.insert(key, QJsonValue(data.toBase64().toStdString().c_str()));
    mJson["buildlist"] = QJsonValue(buildlistObject);
}
