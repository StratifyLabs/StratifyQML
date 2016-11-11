/*
Copyright 2016 Tyler Gilbert

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

import QtQuick 2.6
import "."

SItem {
    id: panelRoot;
    default property alias data: contents.data;
    property string heading_bg: theme.panel_default_heading_bg;
    property string border_color: theme.panel_default_border;
    property real heading_font_size: theme.font_size_base;
    property string heading_color: theme.text_color;
    property string body_color: theme.text_color;
    property alias body: panelBodyText.text;
    property alias heading: panelHeadingText.text;


    implicitWidth: parent.width;
    implicitHeight: panelHeading.height + panelBody.height;
    blockWidth: true;

    onStyleChanged: {
        var items = parseStyle();
        var i;
        for(i=0; i < items.length; i++){
            if( items[i] === "panel-primary" ){
                heading_bg = theme.panel_primary_heading_bg;
                border_color = theme.panel_primary_border;
                heading_color = theme.panel_primary_text;
            } else if( items[i] === "panel-success" ){
                heading_bg = theme.panel_success_heading_bg;
                border_color = theme.panel_success_border;
                heading_color = theme.panel_success_text;
            } else if( items[i] === "panel-danger" ){
                heading_bg = theme.panel_danger_heading_bg;
                border_color = theme.panel_danger_border;
                heading_color = theme.panel_danger_text;
            } else if( items[i] === "panel-warning" ){
                heading_bg = theme.panel_warning_heading_bg;
                border_color = theme.panel_warning_border;
                heading_color = theme.panel_warning_text;
            } else if( items[i] === "panel-info" ){
                heading_bg = theme.panel_info_heading_bg;
                border_color = theme.panel_info_border;
                heading_color = theme.panel_info_text;
            } else if( items[i] === "panel-default" ){
                heading_bg = theme.panel_default_heading_bg;
                border_color = theme.panel_default_border;
                heading_color = theme.panel_default_text;
            }
        }
    }

    SRoundedRectangle {
        id: panelHeading;
        topRadius: theme.panel_border_radius;
        color: heading_bg;
        borderColor: border_color;
        borderWidth: 1;
        visible: panelHeadingText.text != "";

        implicitWidth: parent.width;
        implicitHeight: panelHeadingText.height;

        Text {
            id: panelHeadingText;
            topPadding: theme.padding_base_vertical;
            bottomPadding: theme.padding_base_vertical;
            leftPadding: theme.padding_base_horizontal;
            rightPadding: theme.padding_base_horizontal;
            text: "";
            color: heading_color;
            font.pointSize: heading_font_size;
            font.family: textFont;
            font.weight: Font.Light;
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
        }
    }

    SRoundedRectangle {
        id: panelBody;
        y: panelHeading.visible ? 0 : panelHeading.height - 2*pixelRatio*panelHeading.borderWidth - borderWidth;
        topRadius: panelHeading.visible ? 0 : theme.panel_border_radius;
        bottomRadius: theme.panel_border_radius;
        color: theme.body_bg;
        borderColor: border_color;
        borderWidth: 1;
        width: parent.width;
        implicitHeight: contents.height;

        SContainer {
            id: contents;
            Text {
                id: panelBodyText;
                width: parent.width-2;
                text: "";
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
                font.pointSize: fontSize;
                font.family: textFont;
                font.weight: Font.Light;
            }
        }
    }

}
