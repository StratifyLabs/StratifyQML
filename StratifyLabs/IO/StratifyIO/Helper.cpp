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

#include "Helper.h"

using namespace StratifyIO;

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
