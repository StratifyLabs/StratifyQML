#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QString>

namespace StratifyData {

class DataService : public QObject
{
    Q_OBJECT
public:
    DataService();

    //TO DO Add authentication API

    virtual void getValue(const QString & token, QString & value) = 0;
    virtual void putValue(const QString & token, const QString & value) = 0;
    virtual void post(const QString & token, const QString & value) = 0;
    virtual void patch(const QString & token, const QString & value) = 0;
    virtual void deleteValue(const QString & token) = 0;


private:



};

}

#endif // DATAMANAGER_H
