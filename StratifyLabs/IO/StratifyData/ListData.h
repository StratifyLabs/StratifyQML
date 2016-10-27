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

#ifndef LISTDATA_H
#define LISTDATA_H


#include <QString>
#include <QStringList>
#include "Data.h"

namespace StratifyData {

class ListData : public Data {

public:
    ListData(DataService * service = 0);

    int count();
    QJsonObject at(int i);

    bool append(const QJsonObject & object);
    bool append(const QString & value);
    bool append(const Data * data);

    //this is used by postValue in DataService to set the unique name of the new item
    void setPostName(const QString &name);

private:
    QJsonObject mPostObject;
    bool mIsPostPending;


};

}

#endif // LISTDATA_H
