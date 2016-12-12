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

#ifndef USER_H
#define USER_H

#include <QString>
#include "Data.h"

namespace StratifyData {

class UserData : public Data
{
public:
    UserData(DataService * service = 0);
    UserData(const QJsonObject & object, DataService * service = 0);

    virtual bool validate();

    QString name() const;
    QString email() const;
    QString handle() const;
    QString uid() const;

    void setName(const QString & value);
    void setEmail(const QString & value);
    void setHandle(const QString & value);
    void setUid(const QString & value);



};

}

#endif // USER_H
