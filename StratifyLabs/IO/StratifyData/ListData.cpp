#include "ListData.h"

#include <QDebug>

using namespace StratifyData;


ListData::ListData(DataService * service) : Data(service){
    mIsPostPending = false;
}

int ListData::count(){
    return json().keys().count();
}

QJsonObject ListData::at(int i){
    return json().value(json().keys().at(i)).toObject();
}

void ListData::setPostName(const QString & name){
    mIsPostPending = false;

    if( name.isEmpty() ){
        return;
    }
    qDebug() << Q_FUNC_INFO << "Set post name" << name;
    QJsonDocument doc = QJsonDocument::fromJson(name.toUtf8());
    mJson.insert(doc.object().value("name").toString(), mPostObject);
    mPostObject = QJsonObject();

}


bool ListData::append(const Data * data){
    return append(data->json());
}

bool ListData::append(const QJsonObject & object){
    mPostObject = object;
    QJsonDocument doc;
    doc.setObject(object);
    return append(doc.toJson());
}

bool ListData::append(const QString & value){
    if( mIsPostPending ){
        return false;
    }
    mIsPostPending = true;
    QJsonDocument doc = QJsonDocument::fromJson(value.toUtf8());
    mPostObject = doc.object();
    postValue(value);
    return true;
}
