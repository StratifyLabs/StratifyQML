#ifndef LISTDATA_H
#define LISTDATA_H


#include <QString>
#include <QStringList>
#include "Data.h"

namespace StratifyData {

class ListData : public Data {

public:
    ListData(DataService * service = 0);

    int count();
    QJsonObject at(int i);

    bool append(const QJsonObject & object);
    bool append(const QString & value);
    bool append(const Data * data);

    //this is used by postValue in DataService to set the unique name of the new item
    void setPostName(const QString &name);

private:
    QJsonObject mPostObject;
    bool mIsPostPending;


};

}

#endif // LISTDATA_H
