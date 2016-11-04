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
    property alias text: input.text;
    property string placeholder: "";

    blockWidth: true;
    backgroundColor: theme.input_bg;
    borderColor: theme.input_border;
    radius: theme.input_border_radius;

    property bool showPlaceholder: false;

    property alias inputObject: input;
    property alias contents: input;

    implicitHeight: fontSize + paddingVertical*3;
    width: parent.width;

    signal editingFinished();
    signal returnPressed();

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
        color: showPlaceholder ? Qt.lighter(textColor, 2.0) : textColor;
        width: parent.width - clearIcon.width*1.25;
        leftPadding: paddingHorizontal;
        rightPadding: paddingHorizontal;
        bottomPadding: paddingVertical;
        topPadding: paddingVertical;
        font.pointSize: fontSize;
        font.family: textFont;
        horizontalAlignment: TextEdit.AlignLeft;
        verticalAlignment: TextEdit.AlignVCenter;
        selectByMouse: true;
        selectionColor: Qt.lighter(textColor, 3.0);
        selectedTextColor: textColor;
        clip: true;

        onTextChanged: {
            if( focus === false ){
                baseRectangleInput.editingFinished();
            }
        }

        onEditingFinished: {
            baseRectangleInput.editingFinished();
        }

        Keys.onReturnPressed: {
            baseRectangleInput.editingFinished();
            returnPressed();
        }


    }

    Text {
        id: clearIcon;
        color: theme.gray_light;
        text: Fa.Icon.times_circle;
        font.pointSize: fontSize;
        anchors.right: parent.right;
        font.family: iconFont;
        rightPadding: paddingHorizontal;
        font.weight: Font.Light;
        horizontalAlignment: Text.AlignHCenter;
        verticalAlignment: Text.AlignVCenter;
        height: parent.height;
        visible: input.text !== "";


        MouseArea {
            anchors.fill: parent;
            onClicked: {
                input.text = "";
                input.forceActiveFocus();
            }
        }
    }

}
