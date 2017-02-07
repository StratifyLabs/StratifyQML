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
import StratifyLabs.UI 2.0

Rectangle {
    id: base;

    property alias properties: properties;
    property alias style: properties.style;
    property alias span: properties.span;
    property alias text: text.text;

    implicitWidth: text.width;
    implicitHeight: text.height;

    SProperties {
        id: properties;
        type: "well";
        backgroundColor: StratifyUI.well_bg;
        borderColor: StratifyUI.well_border;
        blockWidth: true;
        fontVerticalAlignment: Text.AlignTop;
        fontHorizontalAlignment: Text.AlignLeft;

        onStyleChanged: {
            var items = parseStyle();
            var i;
            for(i=0; i < items.length; i++){
                if( items[i] === "well-sm" ){
                    properties.paddingVertical = Qt.binding( function(){ return StratifyUI.padding_small_vertical; });
                    properties.paddingHorizontal = Qt.binding( function(){ return StratifyUI.padding_small_horizontal; });
                    properties.fontSize = Qt.binding( function(){ return StratifyUI.font_size_small; });
                } else if( items[i] === "well-lg" ){
                    properties.paddingVertical = Qt.binding( function(){ return StratifyUI.padding_large_vertical; });
                    properties.paddingHorizontal = Qt.binding( function(){ return StratifyUI.padding_large_horizontal; });
                    properties.fontSize = Qt.binding( function(){ return StratifyUI.font_size_large; });
                } else if( items[i] === "well-xs" ){
                    properties.paddingVertical = Qt.binding( function(){ return StratifyUI.padding_xs_vertical; });
                    properties.paddingHorizontal = Qt.binding( function(){ return StratifyUI.padding_xs_horizontal; });
                    properties.fontSize = Qt.binding( function(){ return StratifyUI.font_size_small; });
                } else if( items[i] === "well-default" ){
                    properties.paddingVertical = Qt.binding( function(){ return StratifyUI.padding_base_vertical; });
                    properties.paddingHorizontal = Qt.binding( function(){ return StratifyUI.padding_base_vertical; });
                    properties.fontSize = Qt.binding( function(){ return StratifyUI.font_size_base; });
                }
            }
        }
    }

    color: properties.backgroundColor;
    border.color:  properties.borderColor;
    border.width: properties.borderWidth;
    radius: properties.borderRadius;

    Text {
        id: text;
        rightPadding: properties.paddingHorizontal;
        leftPadding: properties.paddingHorizontal;
        topPadding: properties.paddingVertical;
        bottomPadding: properties.paddingVertical;
        color: properties.fontColor;
        font.family: properties.fontText;
        font.pixelSize: properties.fontSize;
        font.weight: properties.fontWeight;
        wrapMode: Text.Wrap;
        horizontalAlignment: properties.fontHorizontalAlignment;
        verticalAlignment: properties.fontVerticalAlignment;
    }

}
