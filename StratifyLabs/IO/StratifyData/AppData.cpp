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
    return json().value( AppData::publisherKey() ).toString();
}

QString AppData::version() const {
    return json().value( AppData::versionKey() ).toString();
}

QString AppData::name() const {
    return json().value( AppData::nameKey() ).toString();
}

QString AppData::github() const {
    return json().value( AppData::githubKey() ).toString();
}

QString AppData::description() const {
    return json().value( AppData::descriptionKey() ).toString();
}

int AppData::ram() const {
    return json().value( AppData::ramKey() ).toInt();
}

QString AppData::tags() const {
    return json().value( AppData::tagsKey() ).toString();
}


QString AppData::hardwareId() const {
    return json().value( AppData::hardwareIdKey() ).toString();
}

QString AppData::buildPrefix() const {
    return json().value( AppData::buildPrefixKey() ).toString();
}


QStringList AppData::buildList() const {
    return json().value( AppData::buildListKey() ).toObject().keys();
}

bool AppData::getBuild(const QString & key, const QString & filename){

    QFile file;

    file.setFileName(filename);

    if( file.open(QFile::WriteOnly) == false ){
        emit statusChanged(ERROR, "Failed to create file: " + filename);
        return false;
    }

    QByteArray data;

    data = QByteArray::fromBase64(json().value( AppData::buildListKey() ).toObject().value(key).toString().toStdString().c_str());

    file.write(data);
    file.close();

    return true;
}

void AppData::setVersion(const QString & value){
    mJson[ AppData::versionKey() ] = value;
}

void AppData::setName(const QString & value){
    mJson[ AppData::nameKey() ] = value;
}

void AppData::setGithub(const QString & value){
    mJson[ AppData::githubKey() ] = value;
}

void AppData::setDescription(const QString & value){
    mJson[ AppData::descriptionKey() ] = value;

}

void AppData::setTags(const QString & value){
    mJson[ AppData::tagsKey() ] = value;
}

void AppData::setPublisher(const QString & value){
    mJson[ AppData::publisherKey() ] = value;
}

void AppData::setBuildPrefix(const QString & value){
    mJson[ AppData::buildPrefixKey() ] = value;
}

void AppData::setRam(int value){
    mJson[ AppData::ramKey() ] = value;
}



void AppData::setBuild(const QString & key, const QString & filename){

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

    if( mJson.value( AppData::buildListKey() ).toObject().isEmpty() ){
        mJson.insert( AppData::buildListKey() , QJsonValue(QJsonObject()));
    }

    QJsonObject buildlistObject = mJson.value( AppData::buildListKey() ).toObject();
    buildlistObject.insert(key, QJsonValue(data.toBase64().toStdString().c_str()));
    mJson[ AppData::buildListKey() ] = QJsonValue(buildlistObject);
}
