#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtWebEngine/QtWebEngine>
#include <QtWebView/QtWebView>
#include <QQmlContext>
#include "UserDataProvider.h"
#include <StratifyData/StratifyData.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // Must be initialize to work WebEngineView in QML
    QtWebEngine::initialize();

    QQmlApplicationEngine engine;

    UserDataProvider *provider = new UserDataProvider();
    // Create context
    QQmlContext *context = engine.rootContext();
    context->setContextProperty("userProvider", provider);

    FirebaseDataService *fireService = new FirebaseDataService("https://test-3e97c.firebaseio.com/", "G33jmU56OrIgGSjvS8PEpPbtv860mklheKf8raqb");
    fireService->putValue(fireService, "stratifylink/apps/blinky/helloworld/name/", "hello_world");
    fireService->putValue(fireService, "stratifylink/apps/blinky/helloworld/github/", "https://github.com/StratifyLabs/helloworld");
    fireService->putValue(fireService, "stratifylink/apps/blinky/Blinky/name/", "Blinky");
    fireService->putValue(fireService, "stratifylink/apps/blinky/Blinky/github/", "https://github.com/StratifyLabs/Blinky");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
