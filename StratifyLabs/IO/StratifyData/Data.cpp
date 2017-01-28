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
#include <QJsonDocument>

#include "Data.h"

using namespace StratifyData;

DataService * Data::mDefaultDataService;

Data::Data(DataService * dataService){

    if( dataService != 0 ){
        mDataService = dataService;
    } else {
        mDataService = mDefaultDataService;
    }

}

void Data::checkService(){
    if( mDataService == 0 ){
        mDataService = mDefaultDataService;
    }
}

void Data::setValue(const QString & value){
    QJsonDocument doc = QJsonDocument::fromJson(value.toUtf8());
    mJson = doc.object();
}

void Data::setPostName(const QString & name){
    mPostName = name;
}


void Data::getValue(){
    checkService();
    if( mDataService ){
        mDataService->getValue(this, mPath);
    }
}

void Data::putValue(){
    checkService();
    if( mDataService ){
        mDataService->putValue(this, mPath, value());
    }
}

void Data::postValue(const QString & value){
    checkService();
    if( mDataService ){
        mDataService->postValue(this, mPath, value);
    }
}

void Data::patchValue(){
    checkService();
    if( mDataService ){
        mDataService->patchValue(this, mPath, value());
    }
}


void Data::deleteValue(){
    checkService();
    if( mDataService ){
        mDataService->deleteValue(this, mPath);
    }
}

QString Data::uid() const {
    return json().value( Data::uidKey() ).toString();
}

QString Data::publisher() const {
    return json().value( Data::publisherKey() ).toString();
}

QString Data::version() const {
    return json().value( Data::versionKey() ).toString();
}

QString Data::name() const {
    return json().value( Data::nameKey() ).toString();
}

QString Data::github() const {
    return json().value( Data::githubKey() ).toString();
}

QString Data::description() const {
    return json().value( Data::descriptionKey() ).toString();
}

QString Data::tags() const {
    return json().value( Data::tagsKey() ).toString();
}


QString Data::hardwareId() const {
    return json().value( Data::hardwareIdKey() ).toString();
}

QString Data::buildPrefix() const {
    return json().value( Data::buildPrefixKey() ).toString();
}

QString Data::permissions() const {
    return json().value( Data::permissionsKey() ).toString();
}


QStringList Data::buildList() const {
    return json().value( Data::buildListKey() ).toObject().keys();
}

bool Data::getBuild(const QString & key, const QString & filename, const QString & suffix){

    QFile file;

    file.setFileName(filename + suffix);

    if( file.open(QFile::WriteOnly) == false ){
        emit statusChanged(ERROR, "Failed to create file: " + filename);
        return false;
    }

    QByteArray data;

    data = QByteArray::fromBase64(json().value( Data::buildListKey() ).toObject().value(key).toString().toUtf8());

    file.write(data);
    file.close();

    return true;
}

void Data::setUid(const QString & value){
    mJson[ Data::uidKey() ] = value;
}



void Data::setVersion(const QString & value){
    mJson[ Data::versionKey() ] = value;
}

void Data::setName(const QString & value){
    mJson[ Data::nameKey() ] = value;
}

void Data::setGithub(const QString & value){
    mJson[ Data::githubKey() ] = value;
}

void Data::setDescription(const QString & value){
    mJson[ Data::descriptionKey() ] = value;

}

void Data::setTags(const QString & value){
    mJson[ Data::tagsKey() ] = value;
}

void Data::setPublisher(const QString & value){
    mJson[ Data::publisherKey() ] = value;
}

void Data::setBuildPrefix(const QString & value){
    mJson[ Data::buildPrefixKey() ] = value;
}

void Data::setPermissions(const QString & value){
    if( (value == "public") || (value == "private") || (value == "searchable") ){
        mJson[ Data::permissionsKey() ] = value;
    } else {
        mJson[ Data::permissionsKey() ] = "public";
    }
}


void Data::setBuild(const QString & key, const QString & filename){

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

    if( mJson.value( Data::buildListKey() ).toObject().isEmpty() ){
        mJson.insert( Data::buildListKey() , QJsonValue(QJsonObject()));
    }

    QJsonObject buildlistObject = mJson.value( Data::buildListKey() ).toObject();
    buildlistObject.insert(key, QJsonValue(data.toBase64().toStdString().c_str()));
    mJson[ Data::buildListKey() ] = QJsonValue(buildlistObject);
}

bool Data::createFileFromJson(const QString & path, const QJsonObject & object){
    QFile file;

    file.setFileName(path);

    //open (truncate and write only)
    if( file.open(QFile::WriteOnly) == false ){
        return false;
    }

    QJsonDocument doc(object);
    file.write( doc.toJson() );
    file.close();

    return true;
}

QJsonObject Data::createJsonFromFile(const QString & path){
    QFile inputFile;
    inputFile.setFileName(path);

    if( inputFile.open(QFile::ReadOnly) == false ){
        qDebug() << "Failed to open" << path;
        return QJsonObject();
    }

    QJsonDocument doc = QJsonDocument::fromJson(inputFile.readAll());
    QJsonObject object = doc.object();
    inputFile.close();
    return object;
}



