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
