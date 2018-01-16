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

    property alias style: attr.style;
    property alias span: attr.span;
    property alias attr: attr;
    property alias placeholder: control.placeholderText;

    implicitWidth: contentItem.implicitWidth + attr.paddingHorizontal*2;
    implicitHeight: attr.fontContainerHeight;

    font.family: attr.fontText;
    font.pointSize: attr.fontSize;
    font.weight: attr.fontWeight;
    color: enabled ? attr.fontColor : attr.fontColorMuted;
    selectByMouse: true;
    selectedTextColor: attr.fontColorSelected;
    selectionColor: attr.backgroundColorFontSelection;
    horizontalAlignment: attr.fontHorizontalAlignment;
    verticalAlignment: attr.fontVerticalAlignment;

    background: Rectangle {
        border.color: attr.borderColor;
        border.width: attr.borderWidth;
        color: attr.backgroundColor;
        radius: attr.borderRadius;

        Text {
            anchors.right: parent.right;
            anchors.verticalCenter: parent.verticalCenter;
            visible: control.text;
            font.family: attr.fontIcon;
            font.pointSize: attr.fontSize * 1.2;
            color: attr.fontColorMuted;
            text: Fa.Icon.times;
            rightPadding: attr.paddingHorizontal;
            MouseArea {
                anchors.fill: parent;
                onClicked: control.text = "";
            }
        }

    }

    SAttributes {
        id: attr;
        type: "input";
        borderColor: STheme.gray_light;
        fontHorizontalAlignment: Text.AlignLeft;
        blockWidth: true;
    }

}
