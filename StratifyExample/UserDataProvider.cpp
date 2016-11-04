#include "UserDataProvider.h"

UserDataProvider::UserDataProvider(QObject *parent) : QObject(parent)
{
    m_userID = "";
    m_userID = "";
}

void UserDataProvider::setContext(QQmlContext *context)
{
    if(context != 0)
        m_context = context;
}

QString UserDataProvider::getUserID()
{
    return m_userID;
}

void UserDataProvider::setUserID(QString value)
{
    m_userID = value;
    emit userIDChanged();
}

QString UserDataProvider::getToken()
{
    return m_token;
}

void UserDataProvider::setToken(QString value)
{
    m_token = value;
    emit tokenChanged();
}

void UserDataProvider::saveUserData(QString message)
{
    if(message.contains("UserID:")){
        QString id = message.split(":").last();
        setUserID(id.remove(" "));
    }
    else if(message.contains("Token:")){
        QString token = message.split(":").last();
        setToken(token.remove(" "));
    }
}
