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

RadioButton {
    id: control;

    property alias properties: properties;
    property alias style: properties.style;
    property alias span: properties.span;

    SProperties {
        id: properties;
        backgroundColor: StratifyUI.body_bg;
        borderColor: StratifyUI.body_bg;
        fontHorizontalAlignment: Text.AlignLeft;
    }

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            contentItem.implicitWidth + leftPadding*2 + rightPadding*2);
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             Math.max(contentItem.implicitHeight,
                                      indicator ? indicator.implicitHeight : 0) + topPadding + bottomPadding);

    indicator: Text {
        x: text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2
        text: control.checked ? Fa.Icon.circle : Fa.Icon.circle_o;
        font.family: StratifyUI.font_family_icon.name;
        font.pixelSize: StratifyUI.font_size_base*1.5;
        color: StratifyUI.text_color;
        opacity: enabled ? 1 : 0.3
    }

    contentItem: Text {
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0

        text: control.text
        font.family: StratifyUI.font_family_base.name;
        font.pixelSize: StratifyUI.font_size_base;
        color: StratifyUI.text_color;
        elide: Text.ElideRight
        visible: control.text
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        opacity: enabled ? 1 : 0.3
    }

    background: Rectangle {
        color: properties.backgroundColor;
        radius: properties.borderRadius;
        border.color: properties.borderColor;
        border.width: properties.borderWidth;
    }

}
