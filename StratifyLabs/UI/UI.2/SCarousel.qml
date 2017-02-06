import QtQuick 2.5
import QtQuick.XmlListModel 2.0
import QtQml.Models 2.1
import StratifyLabs.UI 2.0

SItem {

    id: carousel;
    type: "carousel";

    property alias interval: switchViewTimer.interval;
    property bool wrap: true;
    property alias keyboard : carouselView.focus;
    property alias model: carouselView.model;


    keyboard: true;
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
        delegate: delegateComponent;
        anchors.fill: parent;
        focus: true;
        clip: true;
        snapMode: PathView.SnapToItem;
        pathItemCount: 2;
        path: Path {
            startX: -carouselView.width*0.5;
            startY: carouselView.height*0.5;

            PathLine {
                relativeX: carouselView.width;
                relativeY: 0;
            }

            PathLine {
                relativeX: carouselView.width;
                relativeY: 0;
            }
        }
    }

    MouseArea {
        anchors.fill: parent;
        hoverEnabled: true;
        propagateComposedEvents: true;
        acceptedButtons: Qt.NoButton;
        onEntered: {
            if (switchViewTimer.running) {
                switchViewTimer.stop();
            }
        }
        onExited: {
            if (interval>0) {
                switchViewTimer.start();
            }
        }
    }

    SButton {
        id: leftButton;
        anchors.left: carousel.left;
        anchors.top: carousel.top;
        anchors.bottom: carousel.bottom;

        icon: Fa.Icon.chevron_left;

        opacity: theme.carousel_control_opacity;
        backgroundColor: theme.carousel_control_color;
        width: theme.carousel_control_width;
        fontSize: theme.carousel_control_font_size;

        onClicked: {
            carouselView.decrementCurrentIndex();
            switchViewTimer.restart();
        }
    }

    SButton {
        id: rightButton;
        anchors.right: carousel.right;
        anchors.top: carousel.top;
        anchors.bottom: carousel.bottom;

        icon: Fa.Icon.chevron_right;

        opacity: theme.carousel_control_opacity;
        backgroundColor: theme.carousel_control_color;
        width: theme.carousel_control_width;
        fontSize: theme.carousel_control_font_size;

        onClicked: {
            carouselView.incrementCurrentIndex();
            switchViewTimer.restart();
        }
    }



    SRow {
        id: rowIndicators
        anchors.bottom: carousel.bottom;
        anchors.bottomMargin: 4;
        anchors.horizontalCenter: carousel.horizontalCenter;
        clip: true;

        Repeater {
            model: carouselView.model.count;

            SRoundedRectangle {
                id: roundRectangle
                color: carouselView.currentIndex === index ? theme.carousel_indicator_active_bg : "transparent";
                borderColor: theme.carousel_indicator_border_color;

                width: theme.carousel_control_width;
                height: theme.carousel_control_width;
                radius: theme.carousel_control_width;
                opacity: theme.carousel_control_opacity;

                MouseArea {
                    anchors.fill: parent;
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
        interval: 5000;
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

    Component {
        id: delegateComponent
        Item {
            id: delegateItem;

            width: carouselView.width;
            height: carouselView.height;

            Image {
                SText {

                    id: textCaption;
                    text: model.caption;
                    anchors.left: parent.left;
                    anchors.right: parent.right;
                    anchors.bottom: parent.bottom;
                    anchors.bottomMargin: rowIndicators.height + 4
                    textColor: theme.carousel_caption_color;
                }
                id: image;
                anchors.fill: parent;
                source: model.source;
                fillMode: Image.PreserveAspectCrop;
            }
        }
    }

    // For testing purposes (default model)
    XmlListModel {
        id: visualModel;
        source: "http://feeds.nationalgeographic.com/ng/photography/photo-of-the-day/";
        query: "/rss/channel/item";

        XmlRole { name: "source"; query: "substring-before(substring-after(description/string(), 'img src=\"'), '\"')" }
        XmlRole { name: "caption"; query: "title/string()" }

    }

}
