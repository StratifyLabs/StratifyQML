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

#ifndef STRATIFYOBJECT_H
#define STRATIFYOBJECT_H

#include <QObject>
#include "StratifyPrompt.h"

class StratifyObject : public QObject
{
    Q_OBJECT
public:
    explicit StratifyObject(QObject *parent = 0);

    enum {
        FATAL,
        CRITICAL,
        WARNING,
        ERROR,
        INFO,
        DEBUG,
        PROMPT = 0x80
    };

signals:
    void statusChanged(int type, const QString & status); //update status and log
    void progressChanged(int value, int max); //update the user with the progress update
    void connectionChanged();
    void promptChanged(const StratifyPrompt & prompt);


public slots:

};

#endif // STRATIFYOBJECT_H
