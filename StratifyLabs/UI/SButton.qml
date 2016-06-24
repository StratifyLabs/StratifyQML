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
    id: button;
    type: "button";

    signal clicked();

    onStyleChanged: {
        var items = parseStyle();
        radius = theme.btn_border_radius_base;
        for(var i = 0; i < items.length; i++){
            if( (items[i] === "primary") || (items[i] === "btn-primary") ){
                backgroundColor = theme.btn_primary_bg;
                textColor = theme.btn_primary_color;
                borderColor = theme.btn_primary_border;
            } else if( items[i] === "default" || (items[i] === "btn-default") ){
                backgroundColor = theme.btn_default_bg;
                textColor = theme.btn_default_color;
                borderColor = theme.btn_default_border;
            } else if( items[i] === "danger" || (items[i] === "btn-danger") ){
                backgroundColor = theme.btn_danger_bg;
                textColor = theme.btn_danger_color;
                borderColor = theme.btn_danger_border;
            } else if( items[i] === "success" || (items[i] === "btn-success") ){
                backgroundColor = theme.btn_success_bg;
                textColor = theme.btn_success_color;
                borderColor = theme.btn_success_border;
            } else if( items[i] === "info" || (items[i] === "btn-info") ){
                backgroundColor = theme.btn_info_bg;
                textColor = theme.btn_info_color;
                borderColor = theme.btn_info_border;
            } else if( items[i] === "warning" || (items[i] === "btn-warning") ){
                backgroundColor = theme.btn_warning_bg;
                textColor = theme.btn_warning_color;
                borderColor = theme.btn_warning_border;
            } else if( items[i] === "close" || (items[i] === "btn-close")){
                backgroundColor = "transparent";
                textColor = theme.text_muted;
                borderColor = "transparent";
            } else if( items[i] === "lg" || (items[i] === "btn-lg")){
                radius = theme.btn_border_radius_large;
                fontSize = theme.font_size_large;
            } else if( items[i] === "sm" || (items[i] === "btn-sm")){
                radius = theme.btn_border_radius_small;
                fontSize = theme.font_size_small;
            } else if( items[i] === "xs" || (items[i] === "btn-xs")){
                radius = theme.btn_border_radius_small;
                fontSize = theme.font_size_small;
            }
        }
    }

    contents.data: [

        MouseArea {
            anchors.fill: parent;
            hoverEnabled: true;
            onEntered: {
                backgroundColor = Qt.darker(backgroundColor, 1.1);
                borderColor = Qt.darker(borderColor, 1.1);
                startHover();
            }

            onExited: {
                backgroundColor = Qt.lighter(backgroundColor, 1.1);
                borderColor = Qt.lighter(borderColor, 1.1);
                stopHover();
            }

            onClicked: button.clicked();
        }

    ]


}
