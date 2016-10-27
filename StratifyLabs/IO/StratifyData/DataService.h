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

signals:
    void changed();

protected:
    QString mHost;
    QString mToken;
    QVariantMap mValues;




};

}

#endif // DATAMANAGER_H
