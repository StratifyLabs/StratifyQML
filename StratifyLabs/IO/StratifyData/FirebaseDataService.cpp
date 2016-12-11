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

    connect(&mNetworkAccessManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(handleNetworkReply(QNetworkReply*)));

}

FirebaseDataService::~FirebaseDataService(){

}


void FirebaseDataService::handleNetworkReply(QNetworkReply *reply){
    Data * owner = (Data*)reply->parent();
    QJsonDocument doc;
    QJsonObject obj;
    if( reply->operation() == QNetworkAccessManager::GetOperation ){
        owner->setValue( reply->readAll() );
    }

    qDebug() << Q_FUNC_INFO << "Operations:" << reply->operation() << "Error:" << reply->error();

    if( reply->operation() == QNetworkAccessManager::PostOperation ){
        doc = QJsonDocument::fromJson( reply->readAll() );
        obj = doc.object();
        owner->setPostName( obj.value("name").toString() );
    }

    emit owner->changed();

    reply->deleteLater();
}

void FirebaseDataService::getValue(QObject * object, const QString & path){

    QString requestPath = host() + "/" + path + ".json?auth=" + token();
    QNetworkRequest request(requestPath);
    qDebug() << Q_FUNC_INFO << requestPath;

    QNetworkReply *reply = mNetworkAccessManager.get(request);
    qDebug() << Q_FUNC_INFO << reply->error();

    reply->setParent(object);

}

void FirebaseDataService::putValue(QObject * object, const QString & path, const QString & value){

    QString requestPath = host() + "/" + path + ".json?auth=" + token();

    QNetworkRequest request(requestPath);
    request.setHeader(QNetworkRequest::ContentTypeHeader,
                      "application/x-www-form-urlencoded");

    QNetworkReply * reply = mNetworkAccessManager.put(request, value.toUtf8());
    if( reply ){
        reply->setParent(object);
    }
}

void FirebaseDataService::postValue(QObject * object, const QString & path, const QString & value){
    QString requestPath = host() + "/" + path + ".json?auth=" + token();

    QNetworkRequest request(requestPath);
    request.setHeader(QNetworkRequest::ContentTypeHeader,
                      "application/x-www-form-urlencoded");

    QNetworkReply * reply = mNetworkAccessManager.post(request, value.toUtf8());
    if( reply ){
        reply->setParent(object);
    }
}

void FirebaseDataService::patchValue(QObject * object, const QString & path, const QString & value){
    QString requestPath = host() + "/" + path + ".json?auth=" + token() + "?x-http-method-override=PATCH";

    QNetworkRequest request(requestPath);
    request.setHeader(QNetworkRequest::ContentTypeHeader,
                      "application/x-www-form-urlencoded");


    QNetworkReply * reply = mNetworkAccessManager.post(request, value.toUtf8());
    if( reply ){
        reply->setParent(object);
    }


}

void FirebaseDataService::deleteValue(QObject * object, const QString & path){
    QString requestPath = host() + "/" + path + ".json?auth=" + token();

    QNetworkRequest request(requestPath);
    request.setHeader(QNetworkRequest::ContentTypeHeader,
                      "application/x-www-form-urlencoded");

    QNetworkReply * reply = mNetworkAccessManager.deleteResource(request);
    if( reply ){
        reply->setParent(object);
    }
}

void FirebaseDataService::setRules(){

}

