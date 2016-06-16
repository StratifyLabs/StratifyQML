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
import "."

SBaseRectangleText {
    id: label;
    type: "label";

    bg_color: "transparent";
    text_color: Theme.text_color;
    border_color: "transparent";

    signal clicked();

    onStyleChanged: {
        var items = parseStyle();
        radius = Theme.btn_border_radius_base;
        for(var i = 0; i < items.length; i++){
            if( items[i] === "label-primary" ){
                bg_color = Theme.label_primary_bg;
                border_color = Theme.label_primary_bg;
            } else if( items[i] === "label-default" ){
                bg_color = Theme.label_default_bg;
                border_color = Theme.label_default_bg;
            } else if( items[i] === "label-danger" ){
                bg_color = Theme.label_danger_bg;
                border_color = Theme.label_danger_bg;
            } else if( items[i] === "label-success" ){
                bg_color = Theme.label_success_bg;
                border_color = Theme.label_success_bg;
            } else if( items[i] === "label-info" ){
                bg_color = Theme.label_info_bg;
                border_color = Theme.label_info_bg;
            } else if( items[i] === "label-warning" ){
                bg_color = Theme.label_warning_bg;
                border_color = Theme.label_warning_bg;
            } else if( items[i] === "label-lg" ){
                font_size = Theme.font_size_large;
                radius = Theme.btn_border_radius_large;
            } else if( items[i] === "label-sm" ){
                font_size = Theme.font_size_small;
                radius = Theme.btn_border_radius_small;
            }

        }
    }

    contents.data: [
        MouseArea {
            anchors.fill: parent;
            hoverEnabled: true;
            onEntered: startHover();
            onExited: stopHover();
            onClicked: label.clicked();
        }
    ]

}
