import QtQuick 2.5
import QtQuick.XmlListModel 2.0
import QtQml.Models 2.1


SItem {

    id: carousel;
    type: "carousel";

//    var carousel_control_color = "#fff";
//    var carousel_control_width = 15;
//    var carousel_control_opacity = .5;
//    var carousel_control_font_size = 20;
//    var carousel_indicator_active_bg = "#fff";
//    var carousel_indicator_border_color = "#fff";
//    var carousel_caption_color = "#fff";

    property alias interval: switchViewTimer.interval;
    property bool wrap: true;
    property alias keyboard : carouselView.focus

    interval: 5000
    keyboard: true
    Keys.onLeftPressed: {
        if (keyboard) {
            decrementCurrentIndex();
        }
    }
    Keys.onRightPressed: {
        if (keyboard) {
            incrementCurrentIndex();
        }
    }

    PathView{
        Rectangle {
            anchors.fill: parent
            border.color: "red"
            color: "transparent"
            border.width: 1
        }
        id: carouselView;
        model:visualModel;
        anchors.fill: parent;
        focus: true
        clip: true
        snapMode: PathView.SnapToItem
        pathItemCount: 2
        path: Path {
            startX: -carouselView.width*0.5;
            startY: carouselView.height*0.5;

            PathLine {
                relativeX: carouselView.width;
                relativeY: 0
            }

            PathLine {
                relativeX: carouselView.width;
                relativeY: 0
            }
        }
    }

    Timer {
        id: switchViewTimer;
        repeat: true;
        running: true;
        onTriggered: {
            incrementCurrentIndex();
        }
    }

    function incrementCurrentIndex() {
        if (!wrap) {
            if (carouselView.currentIndex === carouselView.count - 1) {
                return;
            }
        }
        carouselView.incrementCurrentIndex();
    }

    function decrementCurrentIndex() {
        if (!wrap) {
            if (carouselView.currentIndex === 0) {
                return;
            }
        }
        carouselView.decrementCurrentIndex();
    }


    DelegateModel {
        id: visualModel

        model: XmlListModel {
            source: "http://feeds.nationalgeographic.com/ng/photography/photo-of-the-day/"
            query: "/rss/channel/item"

            XmlRole { name: "title"; query: "title/string()" }
            XmlRole { name: "imageSource"; query: "substring-before(substring-after(description/string(), 'img src=\"'), '\"')" }
        }

        delegate: Item {
            id: delegateItem

            width: carouselView.width
            height: carouselView.height

            Image {
                id: image
                anchors.fill: parent
                source: imageSource
                fillMode: Image.PreserveAspectCrop
            }
        }
    }
}
