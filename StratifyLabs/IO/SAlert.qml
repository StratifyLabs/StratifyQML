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
