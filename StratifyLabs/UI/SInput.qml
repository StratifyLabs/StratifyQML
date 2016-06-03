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
    type: "input";
    property string text;
    property string placeholder: "";
    blockWidth: true;
    color: Theme.input_bg;
    border_color: Theme.input_border;
    radius: Theme.input_border_radius;

    property bool showPlaceholder: false;
    property alias inputObject: input;

    implicitHeight: font_size + Theme.padding_base_vertical*3;
    width: parent.width;

    onTextChanged: {
        if( text === "" ){
            showPlaceholder = true;
            input.text = placeholder;
        } else {
            showPlaceholder = false;
            input.text = text;
        }
    }

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
        color: showPlaceholder ? Qt.lighter(text_color, 2.0) : text_color;
        text: baseRectangleInput.text;
        width: parent.width - clearIcon.width*1.25;
        leftPadding: padding_horizontal;
        rightPadding: padding_horizontal;
        bottomPadding: padding_vertical;
        topPadding: padding_vertical;
        font.pointSize: font_size;
        font.family: textFont;
        horizontalAlignment: TextEdit.AlignLeft;
        verticalAlignment: TextEdit.AlignVCenter;
        selectByMouse: true;
        selectionColor: Qt.lighter(text_color, 3.0);
        selectedTextColor: text_color;
        clip: true;

        Component.onCompleted: {
            if( text === "" ){
                showPlaceholder = true;
                text = placeholder;
            }
        }

        onEditingFinished: {
            //this breaks any bindings to base text value
            baseRectangleInput.text = text;
        }

        onFocusChanged: {
            if( focus == true ){
                if( showPlaceholder == true ){
                    text = "";
                    showPlaceholder = false;
                }
            }
        }

    }

    Text {
        id: clearIcon;
        color: Theme.gray_lighter;
        text: Fa.Icon.times_circle;
        font.pointSize: font_size;
        anchors.right: parent.right;
        font.family: iconFont;
        rightPadding: padding_horizontal;
        font.weight: Font.Light;
        horizontalAlignment: Text.AlignHCenter;
        verticalAlignment: Text.AlignVCenter;
        height: parent.height;
        visible: !showPlaceholder;


        MouseArea {
            anchors.fill: parent;
            onClicked: {
                showPlaceholder = true;
                input.text = "";
                input.forceActiveFocus();
            }
        }
    }

}
