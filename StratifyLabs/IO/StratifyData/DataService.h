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

#ifndef DATAMANAGER_H
#define DATAMANAGER_H


#include <QJsonObject>
#include <QVariantMap>
#include <QObject>
#include <QString>

namespace StratifyData {

class DataService : public QObject
{
    Q_OBJECT
public:
    DataService();

    //TO DO Add authentication API

    virtual void getValue(QObject * object, const QString & path) = 0;
    virtual void putValue(QObject * object, const QString & path, const QString & value) = 0;
    virtual void postValue(QObject * object, const QString & path, const QString & value) = 0;
    virtual void patchValue(QObject * object, const QString & path, const QString & value) = 0;
    virtual void deleteValue(QObject * object, const QString & path) = 0;

    //QJsonObject value() const;
    const QVariantMap & map() const { return mValues; }

    const QString & host() const { return mHost; }
    const QString & token() const { return mToken; }

    void setHost(const QString & value){ mHost = value; }
    void setToken(const QString & value){ mToken = value; }

signals:
    void changed();

protected:
    QString mHost;
    QString mToken;
    QVariantMap mValues;




};

}

#endif // DATAMANAGER_H
