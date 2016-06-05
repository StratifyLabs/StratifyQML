import QtQuick 2.6
import QtQuick.Window 2.2

//import StratifyLabs.UI 1.0

import "../UI"

Window {
    visible: true

    minimumWidth: 600;
    minimumHeight: 500;

    STest { anchors.fill: parent }

    Component.onCompleted: {
        Theme.screen_sm = 700;
    }

}
