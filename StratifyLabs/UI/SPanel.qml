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

    default property alias data: contents.data;
    property string heading_bg: Theme.panel_default_heading_bg;
    property string border_color: Theme.panel_default_border;
    property real heading_font_size: Theme.font_size_base;
    property string heading_color: Theme.text_color;
    property string body_color: Theme.text_color;
    property real font_size: Theme.font_size_base;
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
                heading_bg = Theme.panel_primary_heading_bg;
                border_color = Theme.panel_primary_border;
                heading_color = Theme.panel_primary_text;
            } else if( items[i] === "panel-success" ){
                heading_bg = Theme.panel_success_heading_bg;
                border_color = Theme.panel_success_border;
                heading_color = Theme.panel_success_text;
            } else if( items[i] === "panel-danger" ){
                heading_bg = Theme.panel_danger_heading_bg;
                border_color = Theme.panel_danger_border;
                heading_color = Theme.panel_danger_text;
            } else if( items[i] === "panel-warning" ){
                heading_bg = Theme.panel_warning_heading_bg;
                border_color = Theme.panel_warning_border;
                heading_color = Theme.panel_warning_text;
            } else if( items[i] === "panel-info" ){
                heading_bg = Theme.panel_info_heading_bg;
                border_color = Theme.panel_info_border;
                heading_color = Theme.panel_info_text;
            } else if( items[i] === "panel-default" ){
                heading_bg = Theme.panel_default_heading_bg;
                border_color = Theme.panel_default_border;
                heading_color = Theme.panel_default_text;
            }
        }
    }


    SRoundedRectangle {
        id: panelHeading;
        topRadius: Theme.panel_border_radius;
        color: heading_bg;
        borderColor: border_color;
        borderWidth: 1;

        implicitWidth: parent.width;
        implicitHeight: panelHeadingText.height;

        Text {
            id: panelHeadingText;
            topPadding: Theme.padding_base_vertical;
            bottomPadding: Theme.padding_base_vertical;
            leftPadding: Theme.padding_base_horizontal;
            rightPadding: Theme.padding_base_horizontal;
            text: "Panel Heading";
            color: heading_color;
            font.pointSize: heading_font_size;
            font.family: Theme.opensans.name;
            font.weight: Font.Light;
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
        }
    }

    SRoundedRectangle {
        id: panelBody;
        y: panelHeading.height - 2*panelHeading.borderWidth - borderWidth;
        bottomRadius: Theme.panel_border_radius;
        color: Theme.body_bg;
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
                font.pointSize: font_size;
                font.family: Theme.opensans.name;
                font.weight: Font.Light;
            }
        }
    }

}
