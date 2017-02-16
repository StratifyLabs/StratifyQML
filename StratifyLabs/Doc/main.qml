import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
import StratifyLabs.UI 2.0


ApplicationWindow {
    minimumWidth: STheme.screen_xs;
    minimumHeight: STheme.screen_xs;

    width: 400;
    height: 600;

    property alias screen: animationContainer.screen;

    onScreenChanged: {
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
            item.active = true;
            drawer.close();
        }

        style: "secondary";

        property string menuStyle: "left btn-naked text-on-secondary";
        SContainer {
            style: "fill";
            attr.paddingHorizontal: 0;
            SPane {
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
        SContainer {
            color: STheme.brand_primary;

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

                Layouts {},
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
            SRow {
                SGroup {
                    id: previousGroup;
                    style: "left";
                    span: 2;
                    SButton {
                        id: previousButton;
                        icon: Fa.Icon.chevron_left;
                        onClicked: screen = animationContainer.previous();
                    }
                    SText {
                        anchors.verticalCenter: previousButton.verticalCenter;
                        id: previousScreen;
                    }
                }
                SGroup {
                    id: nextGroup;
                    style: "right";
                    span: 2;
                    SText {
                        anchors.verticalCenter: nextButton.verticalCenter;
                        id: nextScreen;
                    }
                    SButton {
                        id: nextButton;
                        style: "right";
                        icon: Fa.Icon.chevron_right;
                        onClicked: screen = animationContainer.next();
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
