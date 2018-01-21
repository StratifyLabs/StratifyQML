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

import QtQuick 2.10
import StratifyLabs.UI 3.0

Rectangle {
    id: root;

    property alias style: attr.style;
    property alias span: attr.span;
    property alias attr: attr;

    property alias label: contentIcon.label;
    property alias text: contentIcon.label;

    property alias symbol: contentIcon.symbol;
    property alias iconItem: contentIcon;

    implicitWidth: attr.fontContainerHeight;
    implicitHeight: attr.fontContainerHeight;

    SAttributes {
        id: attr;
        type: "badge";
        color: STheme.btn_primary_bg;
        borderColor: STheme.btn_primary_border;
        fontColor: STheme.btn_primary_color;

        onStyleChanged: {
            var items = parseStyle();
            radius = Qt.binding( function(){ return STheme.btn_border_radius_base; });
            for(var i = 0; i < items.length; i++){
                if( items[i] === "badge-primary" ){
                    color = Qt.binding( function(){ return STheme.label_primary_bg; });
                    borderColor = Qt.binding( function(){ return STheme.label_primary_bg; });
                    fontColor = Qt.binding( function(){ return STheme.label_color; });
                } else if( items[i] === "badge-secondary" ){
                    color = Qt.binding( function(){ return STheme.label_secondary_bg; });
                    borderColor = Qt.binding( function(){ return STheme.label_secondary_bg; });
                    fontColor = Qt.binding( function(){ return STheme.label_color; });
                } else if( items[i] === "badge-danger" ){
                    color = Qt.binding( function(){ return STheme.label_danger_bg; });
                    borderColor = Qt.binding( function(){ return STheme.label_danger_bg; });
                    fontColor = Qt.binding( function(){ return STheme.label_color; });
                } else if( items[i] === "badge-success" ){
                    color = Qt.binding( function(){ return STheme.label_success_bg; });
                    borderColor = Qt.binding( function(){ return STheme.label_success_bg; });
                    fontColor = Qt.binding( function(){ return STheme.label_color; });
                } else if( items[i] === "badge-info" ){
                    color = Qt.binding( function(){ return STheme.label_info_bg; });
                    borderColor = Qt.binding( function(){ return STheme.label_info_bg; });
                    fontColor = Qt.binding( function(){ return STheme.label_color; });
                } else if( items[i] === "badge-warning" ){
                    color = Qt.binding( function(){ return STheme.label_warning_bg; });
                    borderColor = Qt.binding( function(){ return STheme.label_warning_bg; });
                    fontColor = Qt.binding( function(){ return STheme.label_color; });
                } else if( items[i] === "badge-outline-primary" ){
                    fontColor = Qt.binding( function(){ return STheme.label_primary_bg; });
                    borderColor = Qt.binding( function(){ return STheme.label_primary_bg; });
                    color = Qt.binding( function(){ return STheme.label_color; });
                } else if( items[i] === "badge-outline-secondary" ){
                    fontColor = Qt.binding( function(){ return STheme.label_secondary_bg; });
                    borderColor = Qt.binding( function(){ return STheme.label_secondary_bg; });
                    color = Qt.binding( function(){ return STheme.label_color; });
                } else if( items[i] === "badge-outline-danger" ){
                    fontColor = Qt.binding( function(){ return STheme.label_danger_bg; });
                    borderColor = Qt.binding( function(){ return STheme.label_danger_bg; });
                    color = Qt.binding( function(){ return STheme.label_color; });
                } else if( items[i] === "badge-outline-success" ){
                    fontColor = Qt.binding( function(){ return STheme.label_success_bg; });
                    borderColor = Qt.binding( function(){ return STheme.label_success_bg; });
                    color = Qt.binding( function(){ return STheme.label_color; });
                } else if( items[i] === "badge-outline-info" ){
                    fontColor = Qt.binding( function(){ return STheme.label_info_bg; });
                    borderColor = Qt.binding( function(){ return STheme.label_info_bg; });
                    color = Qt.binding( function(){ return STheme.label_color; });
                } else if( items[i] === "badge-outline-warning" ){
                    fontColor = Qt.binding( function(){ return STheme.label_warning_bg; });
                    borderColor = Qt.binding( function(){ return STheme.label_warning_bg; });
                    color = Qt.binding( function(){ return STheme.label_color; });
                } else if( (items[i] === "badge-naked") ){
                    attr.color = "transparent";
                    attr.fontColor = Qt.binding(function(){ return STheme.text_color; });
                    attr.borderColor = attr.color;
                    attr.textColorMuted = attr.fontColor;
                    attr.colorHovered = attr.color;
                }
            }
        }
    }


    SIcon {
        id: contentIcon;
        x: parent.width/2 - width/2;
        y: parent.height/2 - height/2;
        style: root.style;
        attr.fontColor: root.attr.fontColor;
    }

    radius: height > width ? height : width;
    color: root.attr.color;
    border.width: root.attr.borderWidth;
    border.color: root.attr.borderColor;
}
