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

#ifndef HELPER_H
#define HELPER_H

#include <QString>
#include <QStringList>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <stfy/son.h>

namespace StratifyIO {

class Helper
{
public:

    static QString convertStringListToJson(const QStringList & list, const QString & key);
    static bool doesFileExist(const QString & dir, const QString & name);
    static int son_create_from_json(const QString & dest, const QString & source, int son_stack_size = 256);

private:
    static int son_add_json_value(son_t * son, const QJsonValue & value, const QString & valueKey);
    static int son_add_json_array(son_t * son, const QJsonArray & array, const QString & arrayKey);
    static int son_add_json_object(son_t * son, const QJsonObject & object, const QString & objectKey);

};
}

#endif // HELPER_H
