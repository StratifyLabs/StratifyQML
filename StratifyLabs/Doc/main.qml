import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
import StratifyLabs.UI 2.0


ApplicationWindow {
    minimumWidth: STheme.screen_xs;
    minimumHeight: STheme.screen_xs;

    width: 400;
    height: 600;

    SDrawer {
        id: drawer
        width: 250;
        height: parent.height;

        style: "secondary";

        property string menuStyle: "left btn-naked text-on-secondary";
        SContainer {
            style: "fill";
            SPane {
                SColumn {
                    SText { style: "left text-on-primary"; text: "Menu"; }
                    SHLine{ attr.paddingVertical: 0; }
                    SContainer {
                        SRow {
                            SText { span: 10; style: "left text-on-primary text-bold"; text: "Introduction"; }
                            SIcon { span: 2; style: "right text-on-primary"; icon: Fa.Icon.smile_o; }
                        }
                        MouseArea {
                            anchors.fill: parent;
                            onClicked: { animationContainer.screen = "Introduction"; drawer.close(); }
                        }
                    }
                    SButton { style: drawer.menuStyle; text: "Theme"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SButton { style: drawer.menuStyle; text: "Attributes"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SButton { style: drawer.menuStyle; text: "Icons"; onPressed: { animationContainer.screen = text; drawer.close(); } }

                    SHLine{ attr.paddingVertical: 0; }
                    SContainer {
                        style: "padding-zero";
                        SRow {
                            SText { span: 10; style: drawer.menuStyle + " text-bold"; text: "Layouts"; }
                            SIcon { span: 2; style: "right text-on-primary"; icon: Fa.Icon.object_group; }
                        }
                        MouseArea {
                            anchors.fill: parent;
                            onClicked: { animationContainer.screen = "Layouts"; drawer.close(); }
                        }
                    }
                    SButton { style: drawer.menuStyle; text: "Rows"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SButton { style: drawer.menuStyle; text: "Columns"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SButton { style: drawer.menuStyle; text: "Containers"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SButton { style: drawer.menuStyle; text: "AnimationContainers"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SHLine{ attr.paddingVertical: 0; }
                    SRow {
                        SText { span: 10; style: "left text-on-primary text-bold"; text: "Indicators"; }
                        SIcon { span: 2; style: "right text-on-primary"; icon: Fa.Icon.star; }
                    }
                    SButton { style: drawer.menuStyle; text: "Alerts"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SButton { style: drawer.menuStyle; text: "Badges"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SButton { style: drawer.menuStyle; text: "Icons"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SButton { style: drawer.menuStyle; text: "Labels"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SButton { style: drawer.menuStyle; text: "Panels"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SButton { style: drawer.menuStyle; text: "ProgressBars"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SButton { style: drawer.menuStyle; text: "ProgressCircles"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SButton { style: drawer.menuStyle; text: "Text"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SButton { style: drawer.menuStyle; text: "ToolTips"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SButton { style: drawer.menuStyle; text: "Wells"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SHLine{ attr.paddingVertical: 0; }
                    SRow {
                        SText { span: 10; style: "left text-on-primary text-bold"; text: "Input"; }
                        SIcon { span: 2; style: "right text-on-primary"; icon: Fa.Icon.pencil; }
                    }
                    SButton { style: drawer.menuStyle; text: "Buttons"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SButton { style: drawer.menuStyle; text: "CheckBoxes"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SButton { style: drawer.menuStyle; text: "Dropdowns"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SButton { style: drawer.menuStyle; text: "Inputs"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SButton { style: drawer.menuStyle; text: "RadioButtons"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SButton { style: drawer.menuStyle; text: "Sliders"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SButton { style: drawer.menuStyle; text: "TextBoxes"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SHLine{ attr.paddingVertical: 0; }
                    SRow {
                        SText { span: 10; style: "left text-on-primary text-bold"; text: "Models"; }
                        SIcon { span: 2; style: "right text-on-primary"; icon: Fa.Icon.database; }
                    }
                    SButton { style: drawer.menuStyle; text: "Lists"; onPressed: { animationContainer.screen = text; drawer.close(); } }
                    SButton { style: drawer.menuStyle; text: "Tables"; onPressed: { animationContainer.screen = text; drawer.close(); } }
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

            SAnimationFade{ id: animation; }
            screen: "Introduction";

            Component.onCompleted: {
                showScreen(current);
            }

            resources: [
                Introduction {},
                Theme {},
                Attributes {},
                Icons {},
                Layouts {},
                Rows {},
                Columns {},
                Containers {},
                AnimationContainers {},
                Buttons {},
                Panels {},
                Badges {},
                Alerts {},
                Inputs {},
                ProgressBars{},
                Dropdowns {},
                Sliders {},
                Labels {}
            ]
        }
    }



    onWidthChanged: {
        STheme.updateScreenSize(width);
    }

    Component.onCompleted: {
        STheme.brand_primary = "#244E99";
        STheme.brand_secondary = "#666";
    }
}
