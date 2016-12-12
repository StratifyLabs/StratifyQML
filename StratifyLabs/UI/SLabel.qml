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

    signal clicked();

    onStyleChanged: {
        var items = parseStyle();
        radius = theme.btn_border_radius_base;
        for(var i = 0; i < items.length; i++){
            if( items[i] === "label-primary" ){
                backgroundColor = theme.label_primary_bg;
                borderColor = theme.label_primary_bg;
                textColor = theme.label_color;
            } else if( items[i] === "label-default" ){
                backgroundColor = theme.label_default_bg;
                borderColor = theme.label_default_bg;
                textColor = theme.label_color;
            } else if( items[i] === "label-danger" ){
                backgroundColor = theme.label_danger_bg;
                borderColor = theme.label_danger_bg;
                textColor = theme.label_color;
            } else if( items[i] === "label-success" ){
                backgroundColor = theme.label_success_bg;
                borderColor = theme.label_success_bg;
                textColor = theme.label_color;
            } else if( items[i] === "label-info" ){
                backgroundColor = theme.label_info_bg;
                borderColor = theme.label_info_bg;
                textColor = theme.label_color;
            } else if( items[i] === "label-warning" ){
                backgroundColor = theme.label_warning_bg;
                borderColor = theme.label_warning_bg;
                textColor = theme.label_color;
            } else if( items[i] === "label-lg" ){
                fontSize = theme.font_size_large;
                radius = theme.btn_border_radius_large;
                textColor = theme.label_color;
            } else if( items[i] === "label-sm" ){
                fontSize = theme.font_size_small;
                radius = theme.btn_border_radius_small;
                textColor = theme.label_color;
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
