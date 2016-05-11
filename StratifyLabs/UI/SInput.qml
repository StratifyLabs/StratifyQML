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
import "Fa-4.5.0.js" as Fa
import "."

SBaseRectangle {
    id: baseRectangleInput;
    property alias text: input.text;
    property string placeholder: "placeholder";
    type: "input";
    blockWidth: true;
    color: Theme.input_bg;
    border_color: Theme.input_border;
    radius: Theme.input_border_radius;

    property alias inputObject: input;

    implicitHeight: font_size + Theme.padding_base_vertical*3;
    width: parent.width;

    onStyleChanged: {
        var items = style.split(" ");
        for(var i=0; i < items.length; i++){
            if( items[i] === "text-left" ){
                input.horizontalAlignment = Text.AlignLeft;
            } else if( items[i] === "text-right" ){
                input.horizontalAlignment = Text.AlignRight;
            } else if( items[i] === "text-center" ){
                input.horizontalAlignment = Text.AlignHCenter;
            }
        }
    }

    TextInput {
        id: input;
        color: text_color;
        text: placeholder;
        width: parent.width - clearIcon.width*1.25;
        leftPadding: padding_horizontal;
        rightPadding: padding_horizontal;
        bottomPadding: padding_vertical;
        topPadding: padding_vertical;
        font.pointSize: font_size;
        font.family: Theme.font_family_base;
        horizontalAlignment: TextEdit.AlignLeft;
        verticalAlignment: TextEdit.AlignVCenter;
        selectByMouse: true;
        selectionColor: Qt.lighter(text_color, 3.0);
        selectedTextColor: text_color;
        clip: true;
    }

    Text {
        id: clearIcon;
        color: Theme.gray_lighter;
        text: Fa.Icon.times_circle;
        font.pointSize: font_size;
        anchors.right: parent.right;
        font.family: Theme.fontawesome.name;
        rightPadding: padding_horizontal;
        font.weight: Font.Light;
        horizontalAlignment: Text.AlignHCenter;
        verticalAlignment: Text.AlignVCenter;
        height: parent.height;
        visible: input.text !== "";


        MouseArea {
            anchors.fill: parent;
            onClicked: input.text = "";
        }
    }

}
