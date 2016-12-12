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


#include <QFileInfo>
#include <QDebug>
#include <QFile>

#include "Helper.h"

using namespace StratifyIO;

bool Helper::createFileFromJson(const QString & path, const QJsonObject & object){
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


QString Helper::convertStringListToJson(const QStringList & list, const QString & key){
    QJsonObject jsonObject;
    QJsonArray jsonArray;


    foreach(QString entry, list){
        //look for the settings file inside the directory -- if not found -- don't open
        QJsonObject object;
        object.insert(key, QJsonValue(entry));
        jsonArray.push_back(object);
    }

    jsonObject.insert("data", jsonArray);


    return QJsonDocument(jsonObject).toJson();
}

bool Helper::doesFileExist(const QString & dir, const QString & name){
    QFileInfo info;
    info.setFile(dir + "/" + name);
    return info.exists();
}


int Helper::addJsonToSon(son_t * son, const QJsonValue & value, const QString & valueKey){
    int ret = 0;
    const char * k = valueKey.toStdString().c_str();

    switch(value.type()){
    case QJsonValue::Null: ret = son_write_null(son, k); break;
    case QJsonValue::Bool:
        if( value.toBool() ){
            ret = son_write_true(son, k);
        } else {
            ret = son_write_false(son, k);
        }
        break;
    case QJsonValue::Double:
        ret = son_write_float(son, k, (float)value.toDouble());
        break;
    case QJsonValue::String:
        ret = son_write_str(son, k, value.toString().toStdString().c_str());
        break;
    case QJsonValue::Array:
        ret = addJsonArrayToSon(son, value.toArray(), valueKey);
        break;
    case QJsonValue::Object:
        ret = addJsonObjecToSon(son, value.toObject(), valueKey);
        break;
    case QJsonValue::Undefined:

        break;
    }
    return ret;
}

int Helper::addJsonArrayToSon(son_t * son, const QJsonArray & array, const QString & arrayKey){
    int ret = 0;
    if( son_open_array(son, arrayKey.toStdString().c_str(), 1) < 0 ){
        return -1;
    }


    for(int i = 0; i < array.size(); i++){
        if( addJsonToSon(son, array.at(i), QString::number(i)) < 0 ){
            ret = -1;
            break;
        }
    }

    son_close_array(son);
    return ret;
}

int Helper::addJsonObjecToSon(son_t * son, const QJsonObject & object, const QString & objectKey){
    int ret = 0;
    if( son_open_obj(son, objectKey.toStdString().c_str()) < 0 ){
        return -1;
    }

    foreach(QString key, object.keys()){

        //QJsonValue value = object.value(key);
        if( addJsonToSon(son, object.value(key), key) < 0 ){
            ret = -1;
            break;
        }

    }

    son_close_obj(son);
    return ret;
}

QJsonObject Helper::createJsonFromFile(const QString & path){
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


int Helper::createSonFromJson(const QString & dest, const QString & source, int son_stack_size){
    int ret = 0;

    son_stack_t son_stack[son_stack_size];
    son_t son;

    QJsonObject object = createJsonFromFile(source);

    qDebug() << Q_FUNC_INFO << "Set son driver";
    son_set_driver(&son, 0);

    qDebug() << Q_FUNC_INFO << "Create SON file";
    if( son_create(&son, dest.toStdString().c_str(), son_stack, son_stack_size) < 0 ){
        qDebug() << Q_FUNC_INFO << "Failed to create" << dest;
        return -1;
    }

    qDebug() << Q_FUNC_INFO << "Add JSON Object";
    if( addJsonObjecToSon(&son, object, "root") < 0 ){
        qDebug() << Q_FUNC_INFO << "Failed to add root object";
        ret = -1;
    }

    qDebug() << Q_FUNC_INFO << "Close SON file";
    son_close(&son, 0);

    qDebug() << Q_FUNC_INFO << "Return" << ret;
    return ret;

}

QJsonObject Helper::dataToJson(const QString & type, const void * buf, int nbyte){
    QJsonObject object;
    QByteArray data((const char*)buf, nbyte);
    object.insert("type", type);
    object.insert("data", data.toBase64().toStdString().c_str());
    return object;
}

bool Helper::dataFromJson(const QJsonObject & object, const QString & type, void * buf, int nbyte){
    QByteArray data;
    memset(buf, 0, nbyte);
    if( object.value("type").toString() == type ){
        data = QByteArray::fromBase64(object.value("data").toString().toStdString().c_str());
        if( data.size() == nbyte ){
            memcpy(buf, data.data(), nbyte);
            return true;
        }
    }
    return false;
}

