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

using namespace StratifyData;

FirebaseDataService::FirebaseDataService(QString host, QString token)
{
    m_firebase = new Firebase(host);
    m_firebase->setToken(token);
    m_firebase->init();
    m_firebase->listenEvents();

    connect(m_firebase, SIGNAL(eventResponseReady(QString)), this, SLOT(onResponseReady(QString)));
    connect(m_firebase, SIGNAL(eventDataChanged(DataSnapshot*)), this, SLOT(onDataChanged(DataSnapshot*)));
}

FirebaseDataService::FirebaseDataService(Firebase *parentFirebase, QString childName)
{
    if (parentFirebase) {
        m_firebase = parentFirebase->child(childName);
        m_firebase->init();
        m_firebase->listenEvents();

        connect(m_firebase, SIGNAL(eventResponseReady(QString)), this, SLOT(onResponseReady(QString)));
        connect(m_firebase, SIGNAL(eventDataChanged(DataSnapshot*)), this, SLOT(onDataChanged(DataSnapshot*)));
    }
    else
        m_firebase = 0;
}

void FirebaseDataService::getValue(const QString & token, const QString & value){
    if (m_firebase)
        m_firebase->child(token)->getValue();
}

void FirebaseDataService::putValue(const QString & token, const QString & value){
    if (m_firebase)
        m_firebase->child(token)->setValue(value);
}

void FirebaseDataService::post(const QString & token, const QString & value){
    if (m_firebase)
        m_firebase->child(token)->setValue(value);
}

void FirebaseDataService::patch(const QString & token, const QString & value){
    if (m_firebase) {
        m_firebase->child(token)->deleteValue();
        m_firebase->child(token)->setValue(value);
    }
}

void FirebaseDataService::deleteValue(const QString & token){
    if (m_firebase)
        m_firebase->child(token)->deleteValue();
}

Firebase *FirebaseDataService::getFirebase()
{
    return m_firebase;
}

void FirebaseDataService::setRules()
{
    if (m_firebase)
        m_firebase->setRules();
}

void FirebaseDataService::onResponseReady(QString data)
{
    qDebug()<<"answer";
    qDebug()<<data;
}
void FirebaseDataService::onDataChanged(DataSnapshot *data)
{
    qDebug()<<data->getDataMap();
    m_values = data->getDataMap();
}
