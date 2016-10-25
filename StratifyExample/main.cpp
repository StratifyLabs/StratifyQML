#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "FirebaseDataService.h"
using namespace StratifyData;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    FirebaseDataService *fireService = new FirebaseDataService("https://test-3e97c.firebaseio.com/", "G33jmU56OrIgGSjvS8PEpPbtv860mklheKf8raqb");
    fireService->setRules();

    FirebaseDataService *rootFirebase = new  FirebaseDataService(fireService->getFirebase(), "stratifylink");
    FirebaseDataService *childFirebase = new  FirebaseDataService(rootFirebase->getFirebase(), "apps");
    FirebaseDataService *node1 = new  FirebaseDataService(childFirebase->getFirebase(), "blinky");
    FirebaseDataService *node2 = new  FirebaseDataService(childFirebase->getFirebase(), "helloworld");

    node1->getFirebase()->child("github")->setValue("https://github.com/StratifyLabs/Blinky");
    node1->getFirebase()->child("name")->setValue("Test123");

    node2->getFirebase()->child("github")->setValue("https://github.com/StratifyLabs/HelloWorld");
    node2->getFirebase()->child("name")->setValue("test");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
