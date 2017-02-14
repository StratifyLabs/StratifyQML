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
                    SText { style: "left text-on-primary"; text: "Containers"; }
                    SButton { icon: Fa.Icon.chevron_right; style: drawer.menuStyle; text: "Alerts"; onPressed: { tests.screen = text; drawer.close(); } }
                    SButton { icon: Fa.Icon.chevron_right; style: drawer.menuStyle; text: "Panels"; onPressed: { tests.screen = text; drawer.close(); } }
                    SButton { icon: Fa.Icon.chevron_right; style: drawer.menuStyle; text: "Wells"; onPressed: { tests.screen = text; drawer.close(); } }
                    SHLine{ attr.paddingVertical: 0; }
                    SText { style: "left text-on-primary"; text: "Indicators"; }
                    SButton { icon: Fa.Icon.chevron_right; style: drawer.menuStyle; text: "Labels"; onPressed: { tests.screen = text; drawer.close(); } }
                    SButton { icon: Fa.Icon.chevron_right; style: drawer.menuStyle; text: "ProgressBars"; onPressed: { tests.screen = text; drawer.close(); } }
                    SHLine{ attr.paddingVertical: 0; }
                    SText { style: "left text-on-primary"; text: "Input"; }
                    SButton { icon: Fa.Icon.chevron_right; style: drawer.menuStyle; text: "Buttons"; onPressed: { tests.screen = text; drawer.close(); } }
                    SButton { icon: Fa.Icon.chevron_right; style: drawer.menuStyle; text: "Inputs"; onPressed: { tests.screen = text; drawer.close(); } }
                    SButton { icon: Fa.Icon.chevron_right; style: drawer.menuStyle; text: "Dropdowns"; onPressed: { tests.screen = text; drawer.close(); } }
                    SButton { icon: Fa.Icon.chevron_right; style: drawer.menuStyle; text: "Sliders"; onPressed: { tests.screen = text; drawer.close(); } }
                    SHLine{ attr.paddingVertical: 0; }
                    SButton { icon: Fa.Icon.chevron_right; style: drawer.menuStyle; text: "Lists"; onPressed: { tests.screen = text; drawer.close(); } }
                    SButton { icon: Fa.Icon.chevron_right; style: drawer.menuStyle; text: "Tables"; onPressed: { tests.screen = text; drawer.close(); } }
                    SButton { icon: Fa.Icon.chevron_right; style: drawer.menuStyle; text: "ToolTips"; onPressed: { tests.screen = text; drawer.close(); } }
                    SButton { icon: Fa.Icon.chevron_right; style: drawer.menuStyle; text: "Progress"; onPressed: { tests.screen = text; drawer.close(); } }
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
                SButton {
                    span: 1;
                    style: "right btn-naked text-on-primary";
                    icon: Fa.Icon.info_circle;
                    onClicked: aboutModal.open();
                }
            }

        }

        SAnimationContainer {
            id: tests;
            style: "block fill";

            SAnimationFade{ id: animation; }
            screen: "Buttons";

            Component.onCompleted: {
                showScreen(current);
            }

            resources: [
                Buttons {},
                Panels {},
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
        STheme.brand_secondary = "#999";
    }
}
