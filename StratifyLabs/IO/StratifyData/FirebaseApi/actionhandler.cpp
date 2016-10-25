#include "actionhandler.h"
#include <QUrl>
#include <firebase.h>
ActionHandler::ActionHandler()
{
    Firebase *firebase=new Firebase("https://firexample.firebaseio.com/");
    firebase->listenEvents();
    connect(firebase,SIGNAL(eventResponseReady(QString)),this,SLOT(onResponseReady(QString)));
    connect(firebase,SIGNAL(eventDataChanged(DataSnapshot*)),this,SLOT(onDataChanged(DataSnapshot*)));
}
void ActionHandler::onResponseReady(QString data)
{
    qDebug()<<"answer";
    qDebug()<<data;
}
void ActionHandler::onDataChanged(DataSnapshot *data)
{
    qDebug()<<data->getDataMap();
}
