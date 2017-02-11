import QtQuick 2.6
import QtQuick.Window 2.2
import StratifyLabs.UI 2.0


Window {
    minimumWidth: STheme.screen_xs;
    minimumHeight: STheme.screen_xs;

    width: 400;
    height: 600;

    SDrawer {
        id: drawer
        width: 250;
        height: parent.height;

        style: "primary";


        property string menuStyle: "left lg primary block text-left";

        SContainer {
            SColumn {
                SText { style: "left text-primary"; text: "Menu"; }
                SHLine{ attr.paddingVertical: 0; }
                SRadioButton { icon: Fa.Icon.chevron_right; style: "left lg text-primary"; text: "Alerts"; onPressed: { tests.screen = text; drawer.close(); } }
                SRadioButton { icon: Fa.Icon.chevron_right; style: "left lg text-primary"; text: "Panels"; onPressed: { tests.screen = text; drawer.close(); } }
                SRadioButton { icon: Fa.Icon.chevron_right; style: "left lg text-primary"; text: "Wells"; onPressed: { tests.screen = text; drawer.close(); } }
                SHLine{ attr.paddingVertical: 0; }
                SRadioButton { icon: Fa.Icon.chevron_right; style: "left lg text-primary"; text: "Buttons"; onPressed: { tests.screen = text; drawer.close(); } }
                SRadioButton { icon: Fa.Icon.chevron_right; style: "left lg text-primary"; text: "Labels"; onPressed: { tests.screen = text; drawer.close(); } }
                SRadioButton { icon: Fa.Icon.chevron_right; style: "left lg text-primary"; text: "Input"; onPressed: { tests.screen = text; drawer.close(); } }
                SHLine{ attr.paddingVertical: 0; }
                SRadioButton { icon: Fa.Icon.chevron_right; style: "left lg text-primary"; text: "Lists"; onPressed: { tests.screen = text; drawer.close(); } }
                SRadioButton { icon: Fa.Icon.chevron_right; style: "left lg text-primary"; text: "Tables"; onPressed: { tests.screen = text; drawer.close(); } }
                SRadioButton { icon: Fa.Icon.chevron_right; style: "left lg text-primary"; text: "ToolTips"; onPressed: { tests.screen = text; drawer.close(); } }
                SRadioButton { icon: Fa.Icon.chevron_right; style: "left lg text-primary"; text: "Progress"; onPressed: { tests.screen = text; drawer.close(); } }
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
                text: "STheme 2.0 is a QML framework that works, looks, and feels much like the twitter bootstrap HTML framework";
            }
        }
    }



    SColumn {
        style: "block fill";
        SContainer {
            color: STheme.brand_danger;

            SRow {
                SButton {
                    span: 1;
                    style: "left btn-naked";
                    icon: Fa.Icon.bars;
                    onClicked: drawer.open();
                }
                SButton {
                    span: 1;
                    style: "right btn-naked";
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
                Buttons {}
            ]
        }
    }


    onWidthChanged: {
        STheme.updateScreenSize(width);
    }

    Component.onCompleted: {
        STheme.brand_primary = "#244E99";
    }
}
