#ifndef USERDATAPROVIDER_H
#define USERDATAPROVIDER_H

#include <QObject>
#include <QQmlContext>
#include <QDebug>

class UserDataProvider : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString userID READ getUserID WRITE setUserID NOTIFY userIDChanged)
    Q_PROPERTY(QString token READ getToken WRITE setToken NOTIFY tokenChanged)

public:
    explicit UserDataProvider(QObject *parent = 0);

    void setContext(QQmlContext *context);

    QString getUserID();
    void setUserID(QString value);

    QString getToken();
    void setToken(QString value);

    Q_INVOKABLE void saveUserData(QString message);

signals:
    void userIDChanged();
    void tokenChanged();

public slots:

private:
    QString m_userID;
    QString m_token;
    QQmlContext *m_context;
};

#endif // USERDATAPROVIDER_H
