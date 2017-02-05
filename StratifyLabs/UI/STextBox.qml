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

Rectangle {
    id: control;
    property alias style: properties.style;
    property alias span: properties.span;
    property alias properties: properties;
    property alias text: textArea.text;
    property alias placeholder: textArea.placeholderText;
    property alias textArea: textArea;
    property alias flickable: flickable;

    SProperties {
        id: properties;
        borderColor: StratifyUI.gray_light;
    }

    implicitWidth: properties.blockWidth ? (parent.width) : 0;
    implicitHeight: properties.fillHeight ? (parent.height) : 0;

    border.width: properties.borderWidth;
    radius: properties.borderRadius;
    border.color: properties.borderColor;
    color: properties.backgroundColor;

    Flickable {
        id: flickable;
        clip: true;
        anchors.fill: parent;
        flickableDirection: Flickable.VerticalFlick;

        TextArea.flickable: TextArea {
            id: textArea;
            wrapMode: TextArea.Wrap;
            color: properties.fontColor;
            font.pixelSize: properties.fontSize;
            font.family: properties.fontText;
            selectedTextColor: properties.fontColorSelected;
            selectByMouse: true;
            selectByKeyboard: true;
            selectionColor: properties.backgroundColorSelection;
        }

        ScrollBar.vertical: ScrollBar { }
    }
}
