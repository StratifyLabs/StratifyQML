#ifndef FIREBASE_H
#define FIREBASE_H

#include <QObject>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkReply>
#include <QtNetwork/QNetworkRequest>
#include <QUrl>
#include <QUrlQuery>
#include <QDebug>
#include <QtGlobal>
#include <QVariantMap>
#include <QJsonObject>
#include <datasnapshot.h>
class Firebase : public QObject
{
    Q_OBJECT
public:
    explicit Firebase(QObject *parent = 0);
    Firebase(QString hostName, QString child, QString hostRules);
    Firebase(QString hostName);
    void init();
    void setValue(QString str);
    void getValue();
    void deleteValue();
    void setToken(QString);
    void listenEvents();
    Firebase* child(QString childName);
    void setRules();

signals:
    void eventResponseReady(QString);
    void eventDataChanged(DataSnapshot*);
public slots:
    void replyFinished(QNetworkReply*);
    void onReadyRead(QNetworkReply*);
    void eventFinished();
    void eventReadyRead();
private:
    QString host;
    QString m_hostRules;
    QString firebaseToken="";
    QNetworkAccessManager *manager;
    QString currentNode;
    QString latestNode;
    QString buildPath(int);
    QString createJson(QString);
    void open(const QUrl &url);
    QByteArray trimValue(const QByteArray &line) const;
};

#endif // FIREBASE_H
