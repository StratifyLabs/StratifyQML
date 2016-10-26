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

    virtual void getValue(const QString & path, QObject * object) = 0;
    virtual void putValue(const QString & value) = 0;
    virtual void postValue(const QString & value) = 0;
    virtual void patchValue(const QString & value) = 0;
    virtual void deleteValue() = 0;

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
