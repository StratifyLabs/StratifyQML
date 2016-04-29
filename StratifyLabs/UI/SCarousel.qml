
import QtQuick 2.6

SItem {

    id: carousel;
    type: "carousel";

    property alias interval: switchViewTimer.interval;
    property bool wrap: true;
    property bool keyboard : true;

    Keys.onLeftPressed: {
        if (keyboard) {
            carouselView.decrementCurrentIndex();
        }
    }
    Keys.onRightPressed: {
        if (keyboard) {
            carouselView.incrementCurrentIndex();
        }
    }

    PathView{
        id: carouselView;
         model:model
        anchors.fill: parent;
        delegate: delegate
        path: Path {
            startX: 120; startY: 100
            id: pathModel;
//            closed: true;
        }
    }

    Component {
             id: delegate
             Column {
                 id: wrapperDelegate
                 Image {
                     anchors.horizontalCenter: nameText.horizontalCenter
                     width: 64; height: 64
                     source: icon
                 }
                 SText {
                     id: nameText
                     text: name
                     color: wrapperDelegate.PathView.isCurrentItem ? "red" : "black"
                 }
             }
         }

    ListModel {
        id: model
         ListElement {
             name: "Name1"
             icon: ""
         }
         ListElement {
             name: "Name2"
             icon: ""
         }
         ListElement {
             name: "Name3"
             icon: ""
         }
    }

    Timer {
        id: switchViewTimer;
        interval: 5000;
        repeat: true;
        onTriggered: {
            carouselView.incrementCurrentIndex();
        }
    }
}
