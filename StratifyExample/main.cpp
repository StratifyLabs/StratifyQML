#include <QGuiApplication>
#include <QQmlApplicationEngine>


#include <StratifyData/StratifyData.h>

//using namespace StratifyData;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;


    FirebaseDataService dataService("https://test-3e97c.firebaseio.com/", "G33jmU56OrIgGSjvS8PEpPbtv860mklheKf8raqb");
    Data::setDefaultDataService(&dataService);

    AppListData appList; //this will use the default data service
    AppData appData;

    appData.setPath("stratifylink/apps");

    appData.setName("HelloWorld");
    appData.setGithub("https://github.com/StratifyLabs/HelloWorld");

    appList.append(&appData); //add App data to Applist

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));


    return app.exec();
}
