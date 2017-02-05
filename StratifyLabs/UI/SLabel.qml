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
import "."

Label {
    id: control;

    property alias style: properties.style;
    property alias properties: properties;
    property alias span: properties.span;

    font.family: properties.textFont;
    font.bold: true;
    font.pixelSize: properties.fontSize;
    color: properties.textColor;

    leftPadding: properties.paddingHorizontal;
    rightPadding: properties.paddingHorizontal;
    topPadding: properties.paddingVertical;
    bottomPadding: properties.paddingVertical;

    horizontalAlignment: properties.fontHorizontalAlignment;
    verticalAlignment: properties.fontVerticalAlignment;


    background: Rectangle {
        color: properties.backgroundColor;
        border.color: properties.borderColor;
        border.width: properties.borderWidth;
        radius: properties.radius;
    }


    SProperties {
        id: properties;

        onStyleChanged: {
            var items = parseStyle();
            radius = Qt.binding( function(){ return StratifyUI.btn_border_radius_base; });
            for(var i = 0; i < items.length; i++){
                if( items[i] === "label-primary" ){
                    backgroundColor = Qt.binding( function(){ return StratifyUI.label_primary_bg; });
                    borderColor = Qt.binding( function(){ return StratifyUI.label_primary_bg; });
                    textColor = Qt.binding( function(){ return StratifyUI.label_color; });
                } else if( items[i] === "label-default" ){
                    backgroundColor = Qt.binding( function(){ return StratifyUI.label_default_bg; });
                    borderColor = Qt.binding( function(){ return StratifyUI.label_default_bg; });
                    textColor = Qt.binding( function(){ return StratifyUI.label_color; });
                } else if( items[i] === "label-danger" ){
                    backgroundColor = Qt.binding( function(){ return StratifyUI.label_danger_bg; });
                    borderColor = Qt.binding( function(){ return StratifyUI.label_danger_bg; });
                    textColor = Qt.binding( function(){ return StratifyUI.label_color; });
                } else if( items[i] === "label-success" ){
                    backgroundColor = Qt.binding( function(){ return StratifyUI.label_success_bg; });
                    borderColor = Qt.binding( function(){ return StratifyUI.label_success_bg; });
                    textColor = Qt.binding( function(){ return StratifyUI.label_color; });
                } else if( items[i] === "label-info" ){
                    backgroundColor = Qt.binding( function(){ return StratifyUI.label_info_bg; });
                    borderColor = Qt.binding( function(){ return StratifyUI.label_info_bg; });
                    textColor = Qt.binding( function(){ return StratifyUI.label_color; });
                } else if( items[i] === "label-warning" ){
                    backgroundColor = Qt.binding( function(){ return StratifyUI.label_warning_bg; });
                    borderColor = Qt.binding( function(){ return StratifyUI.label_warning_bg; });
                    textColor = Qt.binding( function(){ return StratifyUI.label_color; });
                } else if( items[i] === "label-lg" ){
                    fontSize = Qt.binding( function(){ return StratifyUI.font_size_large; });
                    properties.radius = Qt.binding( function(){ return StratifyUI.btn_border_radius_large; });
                    textColor = Qt.binding( function(){ return StratifyUI.label_color; });
                    properties.paddingVertical = Qt.binding( function(){ return StratifyUI.padding_large_vertical; });
                    properties.paddingHorizontal = Qt.binding( function(){ return StratifyUI.padding_large_horizontal; });
                } else if( items[i] === "label-sm" ){
                    properties.paddingVertical = Qt.binding( function(){ return StratifyUI.padding_small_vertical; });
                    properties.paddingHorizontal = Qt.binding( function(){ return StratifyUI.padding_small_horizontal; });
                    fontSize = Qt.binding( function(){ return StratifyUI.font_size_small; });
                    properties.radius = Qt.binding( function(){ return StratifyUI.btn_border_radius_small; });
                    textColor = Qt.binding( function(){ return StratifyUI.label_color; });
                }
            }
        }
    }
}
