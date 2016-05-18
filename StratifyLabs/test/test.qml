import QtQuick 2.6
import QtQuick.Window 2.2

//import StratifyLabs.UI 1.0

import "../UI"

Window {
    visible: true

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }

    STest {
        anchors.fill: parent
    }



}
