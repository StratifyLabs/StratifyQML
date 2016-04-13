import QtQuick 2.6
import "SCustomize.js" as Theme

SItem {
    type: "alert";
    property alias text: alertText.text;
    property real padding_vertical: Theme.padding_base_vertical;
    property real padding_horizontal: Theme.padding_base_horizontal;
    property real font_size: Theme.font_size_base;

    property string bg_color: Theme.alert_info_bg;
    property string text_color: Theme.alert_info_text;
    property string border_color: Theme.alert_info_border;

    implicitWidth: parent.width;
    implicitHeight: alertRectangle.height;

    onStyleChanged: {
        var items = parseStyle();
        for(var i = 0; i < items.length; i++){
            if( items[i] === "danger" ){
                bg_color = Theme.alert_danger_bg;
                text_color = Theme.alert_danger_text;
                border_color = Theme.alert_danger_border;
            } else if( items[i] === "success" ){
                bg_color = Theme.alert_success_bg;
                text_color = Theme.alert_success_text;
                border_color = Theme.alert_success_border;
            } else if( items[i] === "info" ){
                bg_color = Theme.alert_info_bg;
                text_color = Theme.alert_info_text;
                border_color = Theme.alert_info_border;
            } else if( items[i] === "warning" ){
                bg_color = Theme.alert_warning_bg;
                text_color = Theme.alert_warning_text;
                border_color = Theme.alert_warning_border;
            }
        }
    }

    Rectangle {
        id: alertRectangle;

        implicitWidth: parent.width;
        implicitHeight: alertText.height;

        color: bg_color;
        border.color: border_color;
        border.width: 1;
        radius: Theme.alert_border_radius;


        Text {
            id: alertText;
            anchors.top: parent.top;
            anchors.horizontalCenter: parent.horizontalCenter;
            width: parent.width-2;
            topPadding: padding_vertical;
            bottomPadding: padding_vertical;
            leftPadding: padding_horizontal;
            rightPadding: padding_horizontal;
            text: "";
            color: text_color;
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
            font.pointSize: font_size;
            font.family: openSansLight.name;
            font.weight: Font.Light;
        }

    }

}
