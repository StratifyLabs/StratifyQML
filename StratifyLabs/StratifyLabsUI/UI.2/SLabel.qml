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
import QtQuick.Controls 2.1
import StratifyLabs.UI 2.0

Label {
    id: control;

    property alias style: attr.style;
    property alias attr: attr;
    property alias span: attr.span;

    font.italic: attr.fontItalic;
    font.family: attr.fontText;
    font.weight: attr.fontWeight;
    font.pointSize: attr.fontSize;
    color: attr.textColor;

    leftPadding: attr.paddingHorizontal;
    rightPadding: attr.paddingHorizontal;
    topPadding: attr.paddingVertical;
    bottomPadding: attr.paddingVertical;

    horizontalAlignment: attr.fontHorizontalAlignment;
    verticalAlignment: attr.fontVerticalAlignment;

    background: Rectangle {
        color: attr.color;
        border.color: attr.borderColor;
        border.width: attr.borderWidth;
        radius: attr.radius;
    }


    SAttributes {
        id: attr;
        type: "label";
        fontWeight: Font.Bold;

        onStyleChanged: {
            var items = parseStyle();
            radius = Qt.binding( function(){ return STheme.btn_border_radius_base; });
            for(var i = 0; i < items.length; i++){
                if( items[i] === "label-primary" ){
                    color = Qt.binding( function(){ return STheme.label_primary_bg; });
                    borderColor = Qt.binding( function(){ return STheme.label_primary_bg; });
                    fontColor = Qt.binding( function(){ return STheme.label_color; });
                } else if( items[i] === "label-secondary" ){
                    color = Qt.binding( function(){ return STheme.label_secondary_bg; });
                    borderColor = Qt.binding( function(){ return STheme.label_secondary_bg; });
                    fontColor = Qt.binding( function(){ return STheme.label_color; });
                } else if( items[i] === "label-danger" ){
                    color = Qt.binding( function(){ return STheme.label_danger_bg; });
                    borderColor = Qt.binding( function(){ return STheme.label_danger_bg; });
                    fontColor = Qt.binding( function(){ return STheme.label_color; });
                } else if( items[i] === "label-success" ){
                    color = Qt.binding( function(){ return STheme.label_success_bg; });
                    borderColor = Qt.binding( function(){ return STheme.label_success_bg; });
                    fontColor = Qt.binding( function(){ return STheme.label_color; });
                } else if( items[i] === "label-info" ){
                    color = Qt.binding( function(){ return STheme.label_info_bg; });
                    borderColor = Qt.binding( function(){ return STheme.label_info_bg; });
                    fontColor = Qt.binding( function(){ return STheme.label_color; });
                } else if( items[i] === "label-warning" ){
                    color = Qt.binding( function(){ return STheme.label_warning_bg; });
                    borderColor = Qt.binding( function(){ return STheme.label_warning_bg; });
                    fontColor = Qt.binding( function(){ return STheme.label_color; });
                } else if( (items[i] === "label-naked") ){
                    attr.color = "transparent";
                    attr.fontColor = Qt.binding(function(){ return STheme.text_color; });
                    attr.borderColor = attr.color;
                    attr.textColorMuted = attr.fontColor;
                    attr.colorHovered = attr.color;
                }
            }
        }
    }
}
