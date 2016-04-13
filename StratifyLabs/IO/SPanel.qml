import QtQuick 2.6
import "SCustomize.js" as Theme

SItem {

    property string heading_bg: Theme.panel_default_heading_bg;
    property string border_color: Theme.panel_default_border;
    property real heading_font_size: Theme.font_size_base;
    property string heading_color: Theme.text_color;
    property string body_color: Theme.text_color;
    property real font_size: Theme.font_size_base;
    property alias body: panelBodyText.text;
    property alias heading: panelHeadingText.text;


    implicitWidth: parent.width;
    implicitHeight: panelRectangle.height;

    onStyleChanged: {
        var items = parseStyle();
        var i;
        for(i=0; i < items.length; i++){
            if( items[i] === "primary" ){
                heading_bg = Theme.panel_primary_heading_bg;
                border_color = Theme.panel_primary_border;
                heading_color = Theme.panel_primary_text;
            } else if( items[i] === "success" ){
                heading_bg = Theme.panel_success_heading_bg;
                border_color = Theme.panel_success_border;
                heading_color = Theme.panel_success_text;
            } else if( items[i] === "danger" ){
                heading_bg = Theme.panel_danger_heading_bg;
                border_color = Theme.panel_danger_border;
                heading_color = Theme.panel_danger_text;
            } else if( items[i] === "warning" ){
                heading_bg = Theme.panel_warning_heading_bg;
                border_color = Theme.panel_warning_border;
                heading_color = Theme.panel_warning_text;
            } else if( items[i] === "info" ){
                heading_bg = Theme.panel_info_heading_bg;
                border_color = Theme.panel_info_border;
                heading_color = Theme.panel_info_text;
            } else if( items[i] === "default" ){
                heading_bg = Theme.panel_default_heading_bg;
                border_color = Theme.panel_default_border;
                heading_color = Theme.panel_default_text;
            }
        }
    }

    Rectangle {
        id: panelRectangle;
        radius: Theme.panel_border_radius;
        border.color: border_color;
        border.width: 1;
        color: Theme.body_bg;

        implicitWidth: parent.width;
        implicitHeight: panelHeadingRectangle.height + panelBodyText.height;

        Rectangle { //heading
            id: panelHeadingRectangle;
            radius: Theme.panel_border_radius;
            implicitHeight: panelHeadingText.height;
            anchors.top: parent.top;
            anchors.left: parent.left;
            width: parent.width;
            color: heading_bg;
            border.color: border_color;
            border.width: 1;

            Text {
                id: panelHeadingText;
                topPadding: Theme.padding_base_vertical;
                bottomPadding: Theme.padding_base_vertical;
                leftPadding: Theme.padding_base_horizontal;
                rightPadding: Theme.padding_base_horizontal;
                text: "Panel Heading";
                color: heading_color;
                font.pointSize: heading_font_size;
                font.family: openSansLight.name;
                font.weight: Font.Light;
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
            }

        }

        Rectangle {
            id: panelHeadingMask;
            y: panelHeadingRectangle.height - Theme.panel_border_radius;
            height: Theme.panel_border_radius;
            width: parent.width-2;
            anchors.horizontalCenter: parent.horizontalCenter;
            color: Theme.body_bg;
        }


        Rectangle {
            y: panelHeadingRectangle.height - Theme.panel_border_radius;
            height: 1;
            width: parent.width;
            anchors.horizontalCenter: parent.horizontalCenter;
            color: border_color;
        }


        Text {
            id: panelBodyText;
            y: panelHeadingRectangle.height - Theme.panel_border_radius;
            anchors.horizontalCenter: parent.horizontalCenter;
            width: parent.width-2;
            topPadding: Theme.padding_base_vertical;
            bottomPadding: Theme.padding_base_vertical;
            leftPadding: Theme.padding_base_horizontal;
            rightPadding: Theme.padding_base_horizontal;
            text: "Panel Body";
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
            font.pointSize: font_size;
            font.family: openSansLight.name;
            font.weight: Font.Light;
        }

    }



}
