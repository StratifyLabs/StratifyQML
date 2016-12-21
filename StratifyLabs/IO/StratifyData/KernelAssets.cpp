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

#include <QFile>
#include <QDir>
#include <QDebug>
#include <QJsonObject>
#include <QStringList>

#include "KernelAssets.h"
#include "Data.h"

using namespace StratifyData;

KernelAssets::KernelAssets()
{

}


QStringList KernelAssets::types(){
    QStringList list;
    list.append("test");
    list.append("data");
    list.append("type");
    return list;
}

bool KernelAssets::collect(const QString & path, const QString & source, const QString & dest){
    QJsonObject object;

    object = Data::createJsonFromFile(path + "/" + source);
    if( object.isEmpty() ){ return false; }

    QStringList keys = object.keys();

    foreach(QString key, keys){
        QJsonObject dataObject;

        dataObject = object.value(key).toObject();

        if( dataObject.contains("files") ){
            QJsonObject filesObject = dataObject.value("files").toObject();
            QStringList fileKeys = filesObject.keys();
            foreach(QString fileKey, fileKeys){
                convertBinary(filesObject, path, fileKey);
            }
            dataObject.insert("files", filesObject);
            object.insert(key, dataObject);
        }

        if( dataObject.contains("binary") ){
            if( convertBinary(dataObject, path, "binary") ){
                object.insert(key, dataObject);
            }
        }

        if( dataObject.contains("settings") ){
            if( convertBinary(dataObject, path, "settings") ){
                object.insert(key, dataObject);
            }
        }
    }

    return Data::createFileFromJson(path + "/" + dest, object);
}

bool KernelAssets::extract(const QString & path, const QJsonObject & source, const QString & dest){
    //convert the assets file to a directory structure
    QJsonObject object;

    //source is collected assets
    object = source;
    if( object.isEmpty() ){ return false; }

    QStringList keys = object.keys();

    foreach(QString key, keys){
        QJsonObject dataObject;

        qDebug() << Q_FUNC_INFO << "Process key" << key;

        dataObject = object.value(key).toObject();

        if( dataObject.contains("binary") ){
            convertBase64(dataObject, path, "binary", "binary-base64");
        }

        if( dataObject.contains("settings") ){
            convertBase64(dataObject, path, "settings", "settings-base64");
        }

        if( dataObject.contains("files") ){
            QJsonObject fileObject = dataObject.value("files").toObject();
            QStringList fileKeys = fileObject.keys();
            foreach(QString fileKey, fileKeys){
                if( fileKey.endsWith("-base64") == false ){
                    convertBase64(fileObject, path, fileKey, fileKey + "-base64");
                }
            }
            dataObject.insert("files", fileObject);
        }

        //replace the data object
        object.remove(key);
        object.insert(key, dataObject);
    }

    return Data::createFileFromJson(path + "/" + dest, object);
}

bool KernelAssets::convertBinary(QJsonObject & object, const QString & path, const QString & key){
    QFile file;
    QByteArray data;

    file.setFileName(path + "/" + object.value(key).toString());
    if( file.open(QFile::ReadOnly) == false ){
        qDebug() << Q_FUNC_INFO << "Failed to open file name" << key << ":" << object.value(key).toString();
        return false;
    }
    data = file.readAll();
    file.close();

    object.insert(key + "-base64", QJsonValue(data.toBase64().toStdString().c_str()));
    return true;
}

bool KernelAssets::convertBase64(QJsonObject & object, const QString & path, const QString & destKey, const QString & baseKey){
    QFile file;
    QByteArray data;
    QDir dir;
    QFileInfo info;
    data = QByteArray::fromBase64(object.value(baseKey).toString().toUtf8());
    info.setFile(path + "/" + object.value(destKey).toString());
    if( dir.mkpath(info.path()) == false ){
        return false;
    }
    file.setFileName(path + "/" + object.value(destKey).toString());
    if( file.open(QFile::WriteOnly) == false ){
        qDebug() << Q_FUNC_INFO << "Failed to open file name" << destKey << ":" << object.value(destKey).toString();
        return false;
    }

    file.write(data);
    file.close();

    object.remove(baseKey);

    return true;
}


