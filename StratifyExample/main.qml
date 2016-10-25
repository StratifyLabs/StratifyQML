import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.1

Window {
    visible: true

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }

    Text {
        text: qsTr("Hello World")
        anchors.centerIn: parent
    }
}
