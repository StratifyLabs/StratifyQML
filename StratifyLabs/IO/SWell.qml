import QtQuick 2.6
import "SCustomize.js" as Theme

SItem {
    type: "well";
    property alias text: wellText.text;
    property real padding_vertical: Theme.padding_base_vertical;
    property real padding_horizontal: Theme.padding_base_horizontal;
    property real font_size: Theme.font_size_base;
    implicitWidth: parent.width;
    implicitHeight: wellRectangle.height;

    onStyleChanged: {
        var items = parseStyle();
        var i;
        for(i=0; i < items.length; i++){
            if( items[i] === "sm" ){
                padding_vertical = Theme.padding_small_vertical;
                padding_horizontal = Theme.padding_small_horizontal;
            } else if( items[i] === "lg" ){
                padding_vertical = Theme.padding_large_vertical;
                padding_horizontal = Theme.padding_large_horizontal;
            }
        }
    }

    Rectangle {
        id: wellRectangle;

        implicitWidth: parent.width;
        implicitHeight: wellText.height;

        color: Theme.well_bg;
        border.color: Theme.well_border;
        border.width: 1;
        radius: Theme.panel_border_radius;


        Text {
            id: wellText;
            anchors.top: parent.top;
            anchors.horizontalCenter: parent.horizontalCenter;
            width: parent.width-2;
            topPadding: padding_vertical;
            bottomPadding: padding_vertical;
            leftPadding: padding_horizontal;
            rightPadding: padding_horizontal;
            text: "";
            color: Theme.text_color;
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
            font.pointSize: font_size;
            font.family: openSansLight.name;
            font.weight: Font.Light;
        }

    }

}
