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
    property alias textBox: input;
    property alias text: input.text;
    property string placeholder: "placeholder";
    property alias readOnly: input.readOnly;
    type: "textbox";
    blockWidth: true;
    backgroundColor: theme.input_bg;
    borderColor: theme.input_border;
    radius: theme.input_border_radius;

    property alias inputObject: input;

    implicitHeight: fontSize + paddingVertical*3;
    width: parent.width;

    onStyleChanged: {
        var items = style.split(" ");
        for(var i=0; i < items.length; i++){
            if( items[i] === "text-left" ){
                input.horizontalAlignment = Text.AlignLeft;STextBox
            } else if( items[i] === "text-right" ){
                input.horizontalAlignment = Text.AlignRight;
            } else if( items[i] === "text-center" ){
                input.horizontalAlignment = Text.AlignHCenter;
            } else if( items[i] === "read-only" ){
                readOnly = true;
            }
        }
    }

    Flickable {
        id: flick;
        width: parent.width;
        y: paddingVertical;
        height: parent.height - paddingVertical*2;
        clip: true;

        contentWidth: width;
        contentHeight: input.contentHeight;

        function ensureVisible(r){
            //since text is wrapped -- only need to adjust Y
            if (contentY >= r.y) contentY = r.y;
            else if (contentY+height <= r.y+r.height) contentY = r.y+r.height-height;
        }

        onActiveFocusChanged: {
            console.log("Flick active focus");
        }


        TextEdit {
            id: input;
            color: textColor;
            text: "";
            focus: true;
            leftPadding: paddingHorizontal;
            rightPadding: paddingHorizontal;
            bottomPadding: paddingVertical;
            topPadding: paddingVertical;
            width: baseRectangleInput.width;
            height: contentHeight; //height needs to grow with content so mouse events work
            font.pointSize: fontSize;
            font.family: textFont;
            horizontalAlignment: TextEdit.AlignLeft;
            verticalAlignment: TextEdit.AlignTop;
            selectByMouse: true;
            mouseSelectionMode: TextEdit.SelectCharacters;
            selectionColor: Qt.lighter(textColor, 3.0);
            selectedTextColor: textColor;
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
            onCursorRectangleChanged: flick.ensureVisible(cursorRectangle);

            onTextChanged: {
                if( readOnly ){
                    //if scroll is at the max -- keep it at the max
                    cursorPosition = text.length;
                }
            }
        }

    }

    Rectangle {
        id: scrollBar;
        visible: flick.contentHeight > flick.height;
        radius: theme.badge_border_radius;
        width: 8;
        color: theme.gray_lighter;
        height: calcHeight();
        x: flick.width - width * 1.5;
        y: calcY();

        function calcHeight(){
            var r = flick.height * flick.height / flick.contentHeight;
            if( r < 10 ){
                r = 10;
            }
            return r;
        }

        function calcY(){
            var r;
            r = flick.contentY / flick.contentHeight * flick.height;
            if( r + height > flick.height ){
                r = flick.height - height;
            }

            if( r < 0 ){
                r = 0;
            }

            return r;
        }

        MouseArea {
            id: scrollMouseArea;
            anchors.fill: parent;
            drag {
                target: scrollBar;
                axis: Drag.YAxis;
                minimumY: 0;
                maximumY: flick.height - scrollBar.height;
            }
            onMouseYChanged: {
                if( scrollMouseArea.drag.active ){
                    flick.contentY = scrollBar.y * flick.contentHeight / flick.height;
                }
            }
        }

    }

}
