
import QtQuick 2.6

SItem {

    property alias interval: switchViewTimer.interval
    property bool name: value

    Timer {
        id: switchViewTimer
        interval: 5000
    }
}
