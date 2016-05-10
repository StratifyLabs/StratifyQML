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
import "."

SBaseRectangle {
    id: base;
    property alias text: text.text;
    property alias icon: text.text;
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
                text.font.family = Theme.fontawesome.name;
                text.font.pointSize = font_size + padding_vertical*2;
            } else if( items[i] === "bold" ){
                text.font.weight = Font.Bold;
            }
        }
    }

    contents.data: [
        Text {
            id: text;
            anchors.verticalCenter: parent.verticalCenter;
            verticalAlignment: Text.AlignVCenter;
            leftPadding: padding_horizontal;
            rightPadding: padding_horizontal;
            color: text_color;
            font.pointSize: font_size;
            font.family: Theme.openSansLight.name;
            font.weight: Font.Light;
        }
    ]

    MouseArea {
        anchors.fill: parent;
        hoverEnabled: true;
        onEntered: startHover();
        onExited: stopHover();
    }

}
