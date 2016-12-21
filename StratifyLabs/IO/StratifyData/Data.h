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
#include <QMutex>
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

    static QString nameKey() { return "name"; }
    static QString githubKey() { return "github"; }
    static QString descriptionKey() { return "description"; }
    static QString tagsKey() { return "tags"; }
    static QString versionKey() { return "version"; }
    static QString publisherKey() { return "publisher"; }
    static QString buildListKey() { return "buildlist"; }
    static QString hardwareIdKey() { return "hardwareid"; }
    static QString buildPrefixKey() { return "buildprefix"; }

    QString name() const;
    QString github() const;
    QString description() const;
    QString tags() const;
    QString version() const;
    QString publisher() const;
    QStringList buildList() const;
    QString hardwareId() const;
    QString buildPrefix() const;
    bool getBuild(const QString & key, const QString & filename, const QString & suffix = QString());

    void setVersion(const QString & value);
    void setName(const QString & value);
    void setGithub(const QString & value);
    void setDescription(const QString & value);
    void setTags(const QString & value);
    void setBuild(const QString & key, const QString & filename);
    void setPublisher(const QString & value);
    void setBuildPrefix(const QString & value);

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

    bool isBusy(){
        if( lock() ){
            unlock();
            return false;
        }
        return true;
    }

    bool lock(){ return mMutex.tryLock(); }
    void unlock(){ return mMutex.unlock(); }

    static QJsonObject createJsonFromFile(const QString & path);
    static bool createFileFromJson(const QString & path, const QJsonObject & object);

signals:
    void changed();

public slots:

protected:
    QJsonObject mJson;
    QString mPath;
    QString mPostName;

private:
    QMutex mMutex;
    static DataService * mDefaultDataService;
    DataService * mDataService;
    void checkService();

};

}

#endif // DATA_H
