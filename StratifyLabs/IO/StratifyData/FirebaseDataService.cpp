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

#include "FirebaseDataService.h"
#include "Data.h"

using namespace StratifyData;


FirebaseDataService::FirebaseDataService(QString host, QString token)
{
    mHost = host;
    mToken = token;
    mFirebase = 0;

    connect(&mNetworkAccessManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(handleNetworkReply(QNetworkReply*)));

}

FirebaseDataService::~FirebaseDataService(){
    if( mFirebase ){
        delete mFirebase;
    }
}


void FirebaseDataService::handleNetworkReply(QNetworkReply *reply){
    Data * owner = (Data*)reply->parent();
    owner->setValue( reply->readAll() );
    reply->deleteLater();
    emit owner->changed();
}

void FirebaseDataService::getValue(const QString & path, QObject * object){

    QString requestPath = host() + "/" + path + "/.json?auth=" + token();
    QNetworkRequest request(requestPath);
    qDebug() << "Get value" << requestPath;

    QNetworkReply *reply = mNetworkAccessManager.get(request);
    qDebug() << Q_FUNC_INFO << reply->error();

    reply->setParent(object);

    connect(reply, SIGNAL(readyRead()), this, SLOT(handleReadyRead()));
    connect(reply, SIGNAL(error(QNetworkReply::NetworkError)),
            this, SLOT(handleNetworkError(QNetworkReply::NetworkError)));
    connect(reply, SIGNAL(sslErrors(QList<QSslError>)),
            this, SLOT(handleSslErrors(QList<QSslError>)));

}

void FirebaseDataService::handleReadyRead(){
    qDebug() << "Ready to read";
}

void FirebaseDataService::handleNetworkError(QNetworkReply::NetworkError error){
    qDebug() << "network error";
}


void FirebaseDataService::handleSslErrors(QList<QSslError> sslErrors){
    qDebug() << "Ssl errors";
}

void FirebaseDataService::putValue(const QString & value){
    if (mFirebase)
        mFirebase->setValue(value);
}

void FirebaseDataService::postValue(const QString & value){
    if (mFirebase)
        mFirebase->setValue(value);
}

void FirebaseDataService::patchValue(const QString & value){
    if (mFirebase) {
        mFirebase->deleteValue();
        mFirebase->setValue(value);
    }
}

void FirebaseDataService::deleteValue(){
    if (mFirebase)
        mFirebase->deleteValue();
}

void FirebaseDataService::setRules()
{
    if (mFirebase)
        mFirebase->setRules();
}

void FirebaseDataService::onResponseReady(QString data)
{
    qDebug()<<"answer";
    qDebug()<<data;
}
void FirebaseDataService::onDataChanged(DataSnapshot *data)
{
    qDebug()<<data->getDataMap();
    mValues = data->getDataMap();
    emit changed();
}
