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


#ifndef TRACEVENT_H
#define TRACEVENT_H

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


#endif // TRACEVENT_H
