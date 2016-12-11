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

#ifndef DATAFIREBASE_H
#define DATAFIREBASE_H

#include <QString>
#include <QJsonObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>

#include "DataService.h"

namespace StratifyData {


class FirebaseDataService : public DataService
{
    Q_OBJECT
public:
    FirebaseDataService(QString host = "", QString token = ""); //create the base service
    ~FirebaseDataService();

    virtual void getValue(QObject * object, const QString & path);
    virtual void putValue(QObject * object, const QString & path, const QString & value);
    virtual void postValue(QObject * object, const QString & path, const QString & value);
    virtual void patchValue(QObject * object, const QString & path, const QString & value);
    virtual void deleteValue(QObject * object, const QString & path);
    void setRules();

private slots:
    void handleNetworkReply(QNetworkReply *reply);

private:
    QNetworkAccessManager mNetworkAccessManager;


};

}

#endif // DATAFIREBASE_H
