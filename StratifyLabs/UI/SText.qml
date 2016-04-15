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

SBaseRectangle {
    id: base;
    property alias text: text.text;
    property alias textObject: text;
    property string text_color: Theme.text_color;
    type: "text";
    implicitWidth: text.width;
    implicitHeight: font_size + padding_vertical*3;

    contents.color: "transparent";
    contents.border.color: "transparent";
    onStyleChanged: {
        var items = parseStyle();
        var i;
        for(i=0; i < items.length; i++){
            if( items[i] === "text-left" ){
                text.horizontalAlignment = Text.AlignLeft;
            } else if( items[i] === "text-right" ){
                text.horizontalAlignment = Text.AlignCenter;
            } else if( items[i] === "text-center" ){
                text.horizontalAlignment = Text.AlignRight;
            } else if( items[i] === "fa" ){
                text.font.family = fontawesome.name;
                text.font.pointSize *= 1.15;
            } else if( items[i] === "bold" ){
                text.font.weight = Font.Bold;
            }
        }
    }

    Text {
        id: text;
        topPadding: padding_vertical;
        bottomPadding: padding_vertical;
        leftPadding: padding_horizontal;
        rightPadding: padding_horizontal;
        color: text_color;
        font.pointSize: font_size;
        font.family: openSansLight.name;
        font.weight: Font.Light;
        onHeightChanged: {
            console.log("Height " + font.pointSize);
        }
    }

}
