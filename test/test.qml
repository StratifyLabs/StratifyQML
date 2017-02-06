import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import StratifyLabs.UI 1.0


Window {
    id: window;
    visible: true

    minimumWidth: 200;
    minimumHeight: 500;

    width: 600;

    STest {}


    /*
    SContainer {
        style: "block fill";
        SColumn {
            style: "block fill";
            SRow {
                style: "block";
                SButton { span: 4; style: "btn-default top center"; text: "Hello"; onClicked: drawer.open(); }
                SButton { span: 4; style: "btn-default top center"; text: "Hello"; }
                SButton { span: 4; style: "btn-default top center"; text: "Hello"; }
            }
            SButton { style: "btn-primary"; text: "Hello"; }
            SButton { text: "hello"; style: "btn-default center"; }
            SButton { text: "hello"; style: "btn-default"; }
            SButton { text: "hello"; style: "btn-default"; }
            SButton { text: "hello"; style: "btn-default"; }
            STextBox {
                text: "hello";
                style: "block fill";
            }
        }
    }
    */


    onWidthChanged: {
        StratifyUI.updateScreenSize(width);
    }

    Component.onCompleted: {
        //StratifyUI.brand_primary = "orange";
    }



}
