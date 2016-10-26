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
#include "FirebaseApi/firebase.h"

namespace StratifyData {


class FirebaseDataService : public DataService
{
    Q_OBJECT

public:
    FirebaseDataService(QString host, QString token); //create the base service
    ~FirebaseDataService();

    virtual void getValue(const QString & path, QObject * object);
    virtual void putValue(const QString & value);
    virtual void postValue(const QString & value);
    virtual void patchValue(const QString & value);
    virtual void deleteValue();
    void setRules();

public slots:
    void onResponseReady(QString);
    void onDataChanged(DataSnapshot*);

private slots:
    void handleNetworkReply(QNetworkReply *reply);
    void handleReadyRead();
    void handleNetworkError(QNetworkReply::NetworkError error);
    void handleSslErrors(QList<QSslError> sslErrors);

private:
    QNetworkAccessManager mNetworkAccessManager;

    Firebase * mFirebase;


};

}

#endif // DATAFIREBASE_H
