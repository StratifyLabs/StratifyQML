#include "TraceEvent.h"

#include <QDebug>
#include <QBuffer>
#include "Helper.h"

using namespace StratifyIO;

TraceEvent::TraceEvent(){}

TraceEvent::TraceEvent(const TraceEvent & value){
    memcpy(&mInfo, &(value.mInfo), sizeof(mInfo));
}

TraceEvent::TraceEvent(const QJsonObject & object){
   Helper::dataFromJson(object, "TraceEvent", &mInfo, sizeof(mInfo));
}

QJsonObject TraceEvent::toJson() const{


    return Helper::dataToJson("TraceEvent", &mInfo, sizeof(mInfo));

    /*
    QJsonObject object;

    QByteArray data((char*)&mInfo, sizeof(mInfo));

    object.insert("type", "TraceEvent" );
    object.insert("data", data.toBase64().toStdString().c_str());


    return object;
    */

}

TraceEvent::~TraceEvent(){}

quint64 TraceEvent::clock() const {
    return (quint64)mInfo.posix_timestamp_tv_sec * 1000000000 + mInfo.posix_timestamp_tv_nsec;
}

QString TraceEvent::message() const {
    return QString((char*)mInfo.data);
}

QByteArray TraceEvent::data() const {
    return QByteArray((const char*)mInfo.data, 32);
}


