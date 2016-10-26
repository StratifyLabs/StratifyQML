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

#ifndef DATA_H
#define DATA_H

#include <QString>
#include <QNetworkReply>

#include "StratifyObject.h"
#include "DataService.h"

namespace StratifyData {

class Data : public StratifyObject
{
    Q_OBJECT
public:
    Data(DataService * dataService = 0);

    static void setDefaultDataService(DataService * dataService){ mDefaultDataService = dataService; }
    DataService * defaultDataService(){ return mDefaultDataService; }

    DataService * dataService(){ return mDataService; }

    void setValue(const QString & value);

    QString value() const { return mValue; }
    QJsonObject json() const { return mJson; }

signals:
    void changed();

public slots:

private:
    static DataService * mDefaultDataService;
    DataService * mDataService;

    QJsonObject mJson;

    QString mPath;
    QString mValue;

};

}

#endif // DATA_H
