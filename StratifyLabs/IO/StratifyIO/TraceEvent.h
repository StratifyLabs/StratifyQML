#ifndef NOTIFICATION_H
#define NOTIFICATION_H

#include <QObject>
#include <QString>

namespace StratifyIO {

class TraceEvent : public QObject
{
    Q_OBJECT
public:
    TraceEvent();
    TraceEvent(const TraceEvent & value);
    ~TraceEvent();
};

}

Q_DECLARE_METATYPE(StratifyIO::TraceEvent)


#endif // NOTIFICATION_H
