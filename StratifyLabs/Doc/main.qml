import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
import StratifyLabs.UI 2.0


ApplicationWindow {
    id: window;
    minimumWidth: STheme.screen_xs;
    minimumHeight: STheme.screen_xs;

    width: 400;
    height: 600;

    property bool doPush: false;

    property alias screen: animationContainer.screen;

    onScreenChanged: {
        doPush = true;
        var n = animationContainer.next();
        var p = animationContainer.previous();
        if( (n !== undefined) && (n !== animationContainer.screen) ){
            nextScreen.text = n;
            nextGroup.visible = true;
        } else {
            nextGroup.visible = false;
        }

        if( (p !== undefined) && (p !== animationContainer.screen) ){
            previousScreen.text = p;
            previousGroup.visible = true;
        } else {
            previousGroup.visible = false;
        }
    }

    SDrawer {
        id: drawer
        width: 250;
        height: parent.height;

        function shut(item){
            //other items active are false
            for(var i = 0; i < menuItems.children.length; i++){
                if( menuItems.children[i].active !== undefined ){
                    menuItems.children[i].active = false;
                }
            }
            doPush = false;
            item.active = true;
            drawer.close();
        }

        style: "info";

        property string menuStyle: "left btn-naked text-on-info";
        SContainer {
            style: "fill";
            attr.paddingHorizontal: 0;
            SPane {
                style: "block";
                SColumn {
                    id: menuItems;
                    EDrawerHeading { label: "Menu"; }
                    SHLine{ attr.paddingVertical: 0; }
                    EDrawerHeading { label: "Getting Started"; icon: Fa.Icon.smile_o; }
                    EDrawerItem { label: "Introduction"; }
                    EDrawerItem { label: "Theme"; }
                    EDrawerItem { label: "Attributes"; }
                    EDrawerItem { label: "FontAwesome"; }
                    SHLine{ attr.paddingVertical: 0; }
                    EDrawerHeading { label: "Layouts"; icon: Fa.Icon.object_group; }
                    EDrawerItem { label: "Rows"; }
                    EDrawerItem { label: "Columns"; }
                    EDrawerItem { label: "Containers"; }
                    EDrawerItem { label: "AnimationContainers"; }
                    SHLine{ attr.paddingVertical: 0; }
                    EDrawerHeading { label: "Indicators"; icon: Fa.Icon.star; }
                    EDrawerItem { label: "Alerts"; }
                    EDrawerItem { label: "Badges"; }
                    EDrawerItem { label: "Icons"; }
                    EDrawerItem { label: "Labels"; }
                    EDrawerItem { label: "Panels"; }
                    EDrawerItem { label: "ProgressBars"; }
                    EDrawerItem { label: "ProgressCircles"; }
                    EDrawerItem { label: "Texts"; }
                    EDrawerItem { label: "ToolTips"; }
                    EDrawerItem { label: "Wells"; }
                    SHLine{ attr.paddingVertical: 0; }
                    EDrawerHeading { label: "Input"; icon: Fa.Icon.pencil; }
                    EDrawerItem { label: "Buttons"; }
                    EDrawerItem { label: "CheckBoxes"; }
                    EDrawerItem { label: "Dropdowns"; }
                    EDrawerItem { label: "Inputs"; }
                    EDrawerItem { label: "RadioButtons"; }
                    EDrawerItem { label: "Sliders"; }
                    EDrawerItem { label: "TextBoxes"; }
                    SHLine{ attr.paddingVertical: 0; }
                    EDrawerHeading { label: "Models"; icon: Fa.Icon.database; }
                    EDrawerItem { label: "JsonModels"; }
                    EDrawerItem { label: "Lists"; }
                    EDrawerItem { label: "Tables"; }
                }
            }
        }
    }


    SModal {
        id: aboutModal;
        title: "About";
        standardButtons: 0;
        SColumn {
            SText {
                style: "block";
                text: "StratifyLabs UI 2.0 is a QML framework that works, looks, and feels much like the twitter bootstrap HTML framework";
            }
        }
    }


    SColumn {
        style: "block fill";
        attr.paddingVertical: 0;
        SContainer {
            color: STheme.brand_primary;
            z:1;
            SRow {
                SButton {
                    span: 1;
                    style: "left btn-naked text-on-primary";
                    icon: Fa.Icon.bars;
                    onClicked: drawer.open();
                }

                SLabel {
                    style: "text-on-primary";
                    span: 1;
                    text: animationContainer.screen;
                }
                SButton {
                    span: 1;
                    style: "right btn-naked text-on-primary";
                    icon: Fa.Icon.info_circle;
                    onClicked: aboutModal.open();
                }
            }

        }

        SAnimationContainer {
            id: animationContainer;
            style: "block fill";

            Component.onCompleted: {
                showScreen(current);
            }

            resources: [
                Introduction {},
                Theme {},
                Attributes {},
                FontAwesome {},

                Rows {},
                Columns {},
                Containers {},
                AnimationContainers {},

                Alerts {},
                Badges {},
                Icons {},
                Labels {},
                Panels {},
                ProgressBars{},
                ProgressCircles{},
                Texts{},
                ToolTips{},
                Wells{},

                Buttons {},
                CheckBoxes {},
                Dropdowns {},
                Inputs {},
                RadioButtons {},
                Sliders {},
                TextBoxes {},

                JsonModels{},
                Lists{},
                Tables{}
            ]
        }

        SContainer {
            style: "padding-zero";
            anchors.bottom: parent.bottom;
            Rectangle {
                anchors.fill: parent;
                color: STheme.gray_dark;
                opacity: 0.80;
            }
            SContainer {
                SRow {
                    SGroup {
                        id: previousGroup;
                        style: "left text-on-primary";
                        span: 2;
                        SButton {
                            id: previousButton;
                            style: "left btn-naked text-on-primary";
                            icon: Fa.Icon.chevron_left;
                            onClicked: screen = animationContainer.previous();
                        }
                        SText {
                            style: "text-on-primary";
                            anchors.verticalCenter: previousButton.verticalCenter;
                            id: previousScreen;
                        }
                    }
                    SGroup {
                        id: nextGroup;
                        style: "right text-on-primary";
                        span: 2;
                        SText {
                            style: "text-on-primary";
                            anchors.verticalCenter: nextButton.verticalCenter;
                            id: nextScreen;
                        }
                        SButton {
                            id: nextButton;
                            style: "right btn-naked text-on-primary";
                            icon: Fa.Icon.chevron_right;
                            onClicked: screen = animationContainer.next();
                        }
                    }
                }

            }
        }
    }




    onWidthChanged: {
        STheme.updateScreenSize(width);
    }

    Component.onCompleted: {
        STheme.brand_primary = "#244E99";
        STheme.brand_secondary = "#383838";
        screen = "Introduction";
    }
}
