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
import StratifyLabs.UI 2.0

TextField {
    id: control;

    property alias style: properties.style;
    property alias span: properties.span;
    property alias properties: properties;
    property alias placeholder: control.placeholderText;

    implicitWidth: childrenRect.width;
    implicitHeight: properties.fontContainerHeight;

    font.family: properties.fontText;
    font.pixelSize: properties.fontSize;
    color: enabled ? properties.fontColor : properties.fontColorMuted;
    selectByMouse: true;
    selectedTextColor: properties.fontColorSelected;
    selectionColor: properties.backgroundColorSelection;
    horizontalAlignment: properties.fontHorizontalAlignment;
    verticalAlignment: properties.fontVerticalAlignment;

    background: Rectangle {
        border.color: properties.borderColor;
        border.width: properties.borderWidth;
        color: properties.backgroundColor;
        radius: properties.borderRadius;

        Text {
            anchors.right: parent.right;
            anchors.verticalCenter: parent.verticalCenter;
            visible: control.text;
            font.family: properties.fontIcon;
            font.pixelSize: properties.fontSize * 1.2;
            color: properties.fontColorMuted;
            text: Fa.Icon.times;
            rightPadding: properties.paddingHorizontal;
            MouseArea {
                anchors.fill: parent;
                onClicked: control.text = "";
            }
        }

    }

    SProperties {
        id: properties;
        borderColor: StratifyUI.gray_light;
        fontHorizontalAlignment: Text.AlignLeft;
        blockWidth: true;
    }

}
