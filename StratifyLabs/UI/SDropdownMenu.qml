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

ComboBox {
    id: control;

    /*
    id: control;

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             Math.max(contentItem.implicitHeight,
                                      indicator ? indicator.implicitHeight : 0) + topPadding + bottomPadding)
    baselineOffset: contentItem.y + contentItem.baselineOffset

    spacing: 8
    padding: 6
    leftPadding: padding + 6
    rightPadding: padding + 6

    delegate: ItemDelegate {
        width: control.popup.width
        text: control.textRole ? (Array.isArray(control.model) ? modelData[control.textRole] : model[control.textRole]) : modelData
        font.weight: control.currentIndex === index ? Font.DemiBold : Font.Normal
        highlighted: control.highlightedIndex == index
        hoverEnabled: control.hoverEnabled
    }

    indicator: Image {
        x: control.mirrored ? control.leftPadding : control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        source: "image://default/double-arrow/" + (control.visualFocus ? Default.focusColor : Default.textColor)
        sourceSize.width: width
        sourceSize.height: height
        opacity: enabled ? 1 : 0.3
    }

    contentItem: Text {
        leftPadding: control.mirrored && control.indicator ? control.indicator.width + control.spacing : 0
        rightPadding: !control.mirrored && control.indicator ? control.indicator.width + control.spacing : 0

        text: control.displayText
        font: control.font
        color: control.visualFocus ? Default.focusColor : Default.textColor
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        opacity: enabled ? 1 : 0.3
    }

    background: Rectangle {
        implicitWidth: 120
        implicitHeight: 40

        color: control.visualFocus ? (control.pressed ? Default.focusPressedColor : Default.focusLightColor) :
            (control.pressed || popup.visible ? Default.buttonPressedColor : Default.buttonColor)
        border.color: Default.focusColor
        border.width: control.visualFocus ? 2 : 0
        visible: !control.flat || control.pressed
    }

    popup: Popup {
        y: control.height - (control.visualFocus ? 0 : 1)
        width: control.width
        implicitHeight: contentItem.implicitHeight
        topMargin: 6
        bottomMargin: 6

        contentItem: ListView {
            id: listview
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex
            highlightRangeMode: ListView.ApplyRange
            highlightMoveDuration: 0

            Rectangle {
                z: 10
                parent: listview
                width: listview.width
                height: listview.height
                color: "transparent"
                border.color: Default.frameLightColor
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle { }
    }
    */

}
