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
import "Fa-4.5.0.js" as Fa
import "."

CheckBox {
    id: control;
    property alias properties: properties;
    property alias span: properties.span;
    property alias style: properties.style;

    property string iconChecked: Fa.Icon.check_square_o;
    property string icon: Fa.Icon.square_o;

    SProperties {
        id: properties;
        fontHorizontalAlignment: Text.AlignLeft;
    }


    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             Math.max(contentItem.implicitHeight,
                                      indicator ? indicator.implicitHeight : 0) + topPadding + bottomPadding)
    baselineOffset: contentItem.y + contentItem.baselineOffset

    topPadding: properties.paddingVertical;
    bottomPadding: properties.paddingVertical;
    leftPadding: properties.paddingHorizontal;
    rightPadding: properties.paddingHorizontal;
    spacing: properties.paddingHorizontal/2;

    indicator: Text {
        x: text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2
        text: control.checked ? control.iconChecked: control.icon;
        font.family: properties.fontIcon;
        font.pixelSize: properties.fontSize*1.4;
        color: properties.fontColor;
        opacity: enabled ? 1 : 0.3
    }

    contentItem: Text {
        leftPadding: control.indicator && !control.mirrored ? properties.fontSize + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? properties.fontSize + control.spacing : 0

        text: control.text;
        font.family: properties.fontText;
        font.pixelSize: properties.fontSize;
        color: properties.fontColor;
        visible: true;
        horizontalAlignment: properties.fontHorizontalAlignment;
        verticalAlignment: properties.fontVerticalAlignment;
        opacity: enabled ? 1 : 0.3
    }


    background: Rectangle {
        color: properties.backgroundColor;
        radius: properties.borderRadius;
        border.color: properties.borderColor;
        border.width: properties.borderWidth;
    }

}
