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

    property alias attr: attr;
    property alias style: attr.style;
    property alias span: attr.span;
    property alias text: text.text;
    property alias textArea: text;

    implicitWidth: text.width;
    implicitHeight: text.height;

    SAttributes {
        id: attr;
        type: "well";
        backgroundColor: STheme.well_bg;
        borderColor: STheme.well_border;
        blockWidth: true;
        fontVerticalAlignment: Text.AlignTop;
        fontHorizontalAlignment: Text.AlignLeft;

        onStyleChanged: {
            var items = parseStyle();
            var i;
            for(i=0; i < items.length; i++){
                if( items[i] === "well-sm" ){
                    attr.paddingVertical = Qt.binding( function(){ return STheme.padding_small_vertical; });
                    attr.paddingHorizontal = Qt.binding( function(){ return STheme.padding_small_horizontal; });
                    attr.fontSize = Qt.binding( function(){ return STheme.font_size_small; });
                } else if( items[i] === "well-lg" ){
                    attr.paddingVertical = Qt.binding( function(){ return STheme.padding_large_vertical; });
                    attr.paddingHorizontal = Qt.binding( function(){ return STheme.padding_large_horizontal; });
                    attr.fontSize = Qt.binding( function(){ return STheme.font_size_large; });
                } else if( items[i] === "well-xs" ){
                    attr.paddingVertical = Qt.binding( function(){ return STheme.padding_xs_vertical; });
                    attr.paddingHorizontal = Qt.binding( function(){ return STheme.padding_xs_horizontal; });
                    attr.fontSize = Qt.binding( function(){ return STheme.font_size_small; });
                } else if( items[i] === "well-default" ){
                    attr.paddingVertical = Qt.binding( function(){ return STheme.padding_base_vertical; });
                    attr.paddingHorizontal = Qt.binding( function(){ return STheme.padding_base_vertical; });
                    attr.fontSize = Qt.binding( function(){ return STheme.font_size_base; });
                }
            }
        }
    }

    color: attr.backgroundColor;
    border.color:  attr.borderColor;
    border.width: attr.borderWidth;
    radius: attr.borderRadius;

    Text {
        id: text;
        rightPadding: attr.paddingHorizontal;
        leftPadding: attr.paddingHorizontal;
        topPadding: attr.paddingVertical;
        bottomPadding: attr.paddingVertical;
        color: attr.fontColor;
        font.family: attr.fontText;
        font.pointSize: attr.fontSize;
        font.weight: attr.fontWeight;
        wrapMode: Text.Wrap;
        horizontalAlignment: attr.fontHorizontalAlignment;
        verticalAlignment: attr.fontVerticalAlignment;
    }

}
