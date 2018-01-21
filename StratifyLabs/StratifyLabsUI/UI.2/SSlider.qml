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

Slider {
    id: control;

    property alias style: attr.style;
    property alias attr: attr;
    property alias span: attr.span;

    font.family: attr.fontText;
    font.weight: attr.fontWeight;
    font.pointSize: attr.fontSize;
    //color: attr.textColor;

    leftPadding: attr.paddingHorizontal;
    rightPadding: attr.paddingHorizontal;
    topPadding: attr.paddingVertical;
    bottomPadding: attr.paddingVertical;


    SAttributes {
        id: attr;
        type: "slider";
        fillWidth: true;
        color: STheme.gray_light;
        borderColor: STheme.gray_light;
        backgroundColor: STheme.gray_lighter;
    }

    from: 0.0;
    to: 1.0;
    stepSize: 0.1;

    handle: Rectangle {
        x: control.leftPadding + (horizontal ? control.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (horizontal ? (control.availableHeight - height) / 2 : control.visualPosition * (control.availableHeight - height))
        implicitWidth: attr.fontContainerHeight*4/5;
        implicitHeight: attr.fontContainerHeight*4/5;
        radius: width / 2
        color: control.enabled ? (control.pressed
            ? (attr.colorPressed)
            : (attr.color)) : attr.colorDisabled;
        border.width: attr.borderWidth;
        border.color: control.enabled ? attr.borderColor : attr.colorDisabled;

        readonly property bool horizontal: control.orientation === Qt.Horizontal
    }

    background: Rectangle {
        x: control.leftPadding + (horizontal ? 0 : (control.availableWidth - width) / 2)
        y: control.topPadding + (horizontal ? (control.availableHeight - height) / 2 : 0)
        implicitWidth: horizontal ? 200 : 6
        implicitHeight: horizontal ? 6 : 200
        width: horizontal ? control.availableWidth : implicitWidth
        height: horizontal ? implicitHeight : control.availableHeight
        radius: attr.borderRadius;
        color: control.enabled ? attr.backgroundColor : attr.backgroundColorDisabled;
        scale: horizontal && control.mirrored ? -1 : 1

        readonly property bool horizontal: control.orientation === Qt.Horizontal
    }
}
