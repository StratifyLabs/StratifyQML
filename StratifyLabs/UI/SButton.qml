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

import QtQuick 2.5
import "SCustomize.js" as Theme

SBaseRectangleText {
    id: button;
    type: "btn";

    bg_color: Theme.btn_default_bg;
    text_color: Theme.btn_default_color;
    border_color: Theme.btn_default_border;

    signal clicked();

    onStyleChanged: {
        var items = parseStyle();
        radius = Theme.btn_border_radius_base;
        for(var i = 0; i < items.length; i++){
            if( items[i] === "primary" ){
                bg_color = Theme.btn_primary_bg;
                text_color = Theme.btn_primary_color;
                border_color = Theme.btn_primary_border;
            } else if( items[i] === "default" ){
                bg_color = Theme.btn_default_bg;
                text_color = Theme.btn_default_color;
                border_color = Theme.btn_default_border;
            } else if( items[i] === "danger" ){
                bg_color = Theme.btn_danger_bg;
                text_color = Theme.btn_danger_color;
                border_color = Theme.btn_danger_border;
            } else if( items[i] === "success" ){
                bg_color = Theme.btn_success_bg;
                text_color = Theme.btn_success_color;
                border_color = Theme.btn_success_border;
            } else if( items[i] === "info" ){
                bg_color = Theme.btn_info_bg;
                text_color = Theme.btn_info_color;
                border_color = Theme.btn_info_border;
            } else if( items[i] === "warning" ){
                bg_color = Theme.btn_warning_bg;
                text_color = Theme.btn_warning_color;
                border_color = Theme.btn_warning_border;
            } else if( items[i] === "close" ){
                bg_color = "transparent";
                text_color = Theme.text_muted;
                border_color = "transparent";
            } else if( items[i] === "lg" ){
                radius = Theme.btn_border_radius_large;
            } else if( items[i] === "sm" ){
                radius = Theme.btn_border_radius_small;
            } else if( items[i] === "xs" ){
                radius = Theme.btn_border_radius_small;
            }
        }
    }

    MouseArea {
        anchors.fill: parent;
        hoverEnabled: true;
        onEntered: {
            bg_color = Qt.darker(bg_color, 1.1);
        }

        onExited: {
            bg_color = Qt.lighter(bg_color, 1.1);
        }

        onClicked: button.clicked();
    }


}
