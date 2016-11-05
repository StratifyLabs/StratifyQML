import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick 2.0
import QtWebView 1.1
import QtWebEngine 1.0

ApplicationWindow {
    width: 750
    height: 300
    visible: true

    WebEngineView {
        id: webView
        url: "http://localhost/index.html"
        anchors.fill: parent
        onJavaScriptConsoleMessage: {
            // Store user id and token in appropriate properties in the UserDataProvider class
            userProvider.saveUserData(message);
        }
    }
}
