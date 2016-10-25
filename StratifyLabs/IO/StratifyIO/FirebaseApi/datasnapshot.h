#ifndef DATASNAPSHOT_H
#define DATASNAPSHOT_H

#include <QObject>
#include <QVariantMap>
class DataSnapshot : public QObject
{
    Q_OBJECT
public:
    explicit DataSnapshot(QObject *parent = 0);
    DataSnapshot(QString);
    QVariantMap getDataMap();
    QString getPath();
signals:

public slots:
private:
    QString rawData;
    void parse();
    QVariantMap dataMap;
    QString data_path;
    QString trimValue(const QString &line) const;
};

#endif // DATASNAPSHOT_H
