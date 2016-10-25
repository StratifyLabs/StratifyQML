#include "datasnapshot.h"
#include <qdebug.h>
#include <qjsondocument.h>
#include <qjsonobject.h>
#include <QVariantMap>
DataSnapshot::DataSnapshot(QObject *parent) : QObject(parent)
{

}
DataSnapshot::DataSnapshot(QString data)
{
    rawData=data;
    parse();
}
void DataSnapshot::parse()
{
    rawData=trimValue(rawData);
    QJsonDocument doc = QJsonDocument::fromJson(rawData.toUtf8());
    QVariantMap eventMap = doc.toVariant().toMap();
    QString path = eventMap["path"].toString();
    QVariantMap qDataMap = eventMap["data"].toMap();
    data_path=path;
    dataMap=qDataMap;
}
QString DataSnapshot::trimValue(const QString &line) const
{
    QString value;
    int index = line.indexOf(':');
    if (index > 0)
        value = line.right(line.size() - index  - 1);
    return value.trimmed();
}
QString DataSnapshot::getPath()
{
    return data_path;
}
QVariantMap DataSnapshot::getDataMap()
{
    return dataMap;
}
