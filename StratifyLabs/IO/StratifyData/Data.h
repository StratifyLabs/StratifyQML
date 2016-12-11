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
#include <QJsonObject>
#include <QJsonDocument>

#include "StratifyObject.h"
#include "DataService.h"

namespace StratifyData {

class Data : public StratifyObject
{
    Q_OBJECT
public:
    Data(DataService * dataService = 0);

    void setDataService(DataService * service){ mDataService = service; }

    static void setDefaultDataService(DataService * dataService){ mDefaultDataService = dataService; }
    DataService * defaultDataService(){ return mDefaultDataService; }

    DataService * dataService(){ return mDataService; }

    virtual bool validate(){ return true; }

    void getValue();
    void putValue();
    void postValue(const QString & value); //appends value as a JSON string to the cloud object
    void patchValue();
    void deleteValue();

    void setPath(const QString & path){ mPath = path; }
    const QString & path() const { return mPath; }
    const QString & postName() const { return mPostName; }

    virtual void setPostName(const QString & name); //unique key from a post request
    virtual void setValue(const QString & value);

    QString value() const {
        QJsonDocument doc(mJson);
        return doc.toJson();
    }

    QJsonObject json() const { return mJson; }

    void clear(){ mJson = QJsonObject(); mPostName.clear(); mPath.clear(); }

signals:
    void changed();

public slots:

protected:
    QJsonObject mJson;
    QString mPath;
    QString mPostName;

private:
    static DataService * mDefaultDataService;
    DataService * mDataService;
    void checkService();

};

}

#endif // DATA_H
