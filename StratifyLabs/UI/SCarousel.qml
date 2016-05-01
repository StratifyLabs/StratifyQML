import QtQuick 2.5
import QtQuick.XmlListModel 2.0
import QtQml.Models 2.1
import "SCustomize.js" as Theme
import "Fa-4.5.0.js" as Fa

SItem {

    id: carousel;
    type: "carousel";

    //    var carousel_control_color = "#fff";
    //    var carousel_control_width = 15;
    //    var carousel_control_opacity = .5;
    //    var carousel_control_font_size = 20;
    //    var carousel_indicator_active_bg = "#fff";
    //    var carousel_indicator_border_colocarousel_indicator_active_bgr = "#fff";
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
        id: carouselView;
        model:visualModel;
        delegate: delegateComponent
        anchors.fill: parent;
        focus: true
        clip: true
        snapMode: PathView.SnapToItem
        flickDeceleration: 5000
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

    SButton {
        id: leftButton;
        anchors.left: carousel.left;
        anchors.top: carousel.top;
        anchors.bottom: carousel.bottom;

        text: Fa.Icon.chevron_left;
        opacity: Theme.carousel_control_opacity;
        onClicked: {
            carouselView.decrementCurrentIndex();
        }
    }

    SButton {
        id: rightButton;
        anchors.right: carousel.right;
        anchors.top: carousel.top;
        anchors.bottom: carousel.bottom;

        text: Fa.Icon.chevron_right;
        opacity: Theme.carousel_control_opacity;

        onClicked: {
            carouselView.incrementCurrentIndex();
        }
    }

    SRow {
        anchors.bottom: carousel.bottom
        anchors.bottomMargin: 42
        anchors.horizontalCenter: carousel.horizontalCenter

        Repeater {
            model: carouselView.model.count

            SRoundedRectangle {
                color: carouselView.currentIndex === index ? Theme.carousel_indicator_active_bg : "transparent"
                borderColor: Theme.carousel_indicator_active_bg

                width: Theme.carousel_control_width
                height: Theme.carousel_control_width
                radius: Theme.carousel_control_width
                opacity: Theme.carousel_control_opacity;

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        carouselView.currentIndex = index;
                    }
                }
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



    XmlListModel {
        id: visualModel
        source: "http://feeds.nationalgeographic.com/ng/photography/photo-of-the-day/"
        query: "/rss/channel/item"

        XmlRole { name: "imageSource"; query: "substring-before(substring-after(description/string(), 'img src=\"'), '\"')" }
    }

    Component {
        id: delegateComponent
        Item {
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
