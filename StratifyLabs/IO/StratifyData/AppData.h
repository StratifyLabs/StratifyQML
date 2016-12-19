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

#ifndef APP_H
#define APP_H

#include <QString>

#include "Data.h"

namespace StratifyData {

class AppData : public Data {
    Q_OBJECT
public:
    AppData(DataService * service = 0);
    AppData(const QJsonObject & object, DataService * service = 0);

    virtual bool validate();

    //keys unique to apps
    static QString ramKey() { return "ram"; }


    int ram() const;
    void setRam(int value);

private:
    QString mPath;


};

}

#endif // APP_H
