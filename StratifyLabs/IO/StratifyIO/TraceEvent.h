#ifndef NOTIFICATION_H
#define NOTIFICATION_H

#include <QObject>
#include <QString>
#include <QDateTime>
#include <QJsonObject>
#include <iface/link.h>

namespace StratifyIO {

class TraceEvent {
public:
    TraceEvent();
    TraceEvent(const TraceEvent & value);
    TraceEvent(const QJsonObject & object);
    ~TraceEvent();


    void setInfo(const link_posix_trace_event_info_t & info){
        mInfo = info;
    }

    QString message() const;
    QByteArray data() const;

    int id() const { return mInfo.posix_event_id; }
    quint64 clock() const;
    u32 pid() const { return mInfo.posix_pid; }
    u32 programAddress() const { return mInfo.posix_prog_address; }
    u32 threadId() const { return mInfo.posix_thread_id; }

    QJsonObject toJson() const;

private:
    link_posix_trace_event_info_t mInfo;
};

}


#endif // NOTIFICATION_H
