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

ComboBox {
    id: control;

    property alias icon: indicator.text;
    property alias properties: properties;
    property alias style: properties.style;
    property alias span: properties.span;

    //Legacy 1.0 interfacing
    property alias text: control.currentText;
    property alias activeText: control.currentText;
    signal clicked();
    signal itemClicked();
    onActivated: itemClicked();

    SProperties {
        id: properties;
        blockWidth: true;
    }

    implicitWidth: contentItem.implicitWidth + properties.paddingHorizontal*2;
    implicitHeight: properties.fontContainerHeight;

    baselineOffset: contentItem.y + contentItem.baselineOffset;

    font.family: properties.fontText;
    font.pixelSize: properties.fontSize;
    font.weight: properties.fontWeight;

    spacing: properties.paddingVertical;
    topPadding: properties.paddingVertical;
    bottomPadding: properties.paddingVertical;
    leftPadding: properties.paddingHorizontal;
    rightPadding: properties.paddingHorizontal;

    delegate: ItemDelegate {
        id: delegate;
        width: control.popup.width
        text: control.textRole ? (Array.isArray(control.model) ? modelData[control.textRole] : model[control.textRole]) : modelData

        contentItem: Text {
            leftPadding: control.mirrored ? (control.indicator ? control.indicator.width : 0) + control.spacing : 0
            rightPadding: !control.mirrored ? (control.indicator ? control.indicator.width : 0) + control.spacing : 0

            text: delegate.text
            font: control.font;
            color: delegate.highlighted ? StratifyUI.dropdown_active_color : (delegate.hovered ? StratifyUI.dropdown_hover_color :StratifyUI.text_color);
            elide: Text.ElideRight
            visible: delegate.text
            horizontalAlignment: properties.fontHorizontalAlignment;
            verticalAlignment: properties.fontVerticalAlignment;
        }


        highlighted: control.highlightedIndex == index;
        hoverEnabled: control.hoverEnabled;

        background: Rectangle {
            color: delegate.highlighted ? StratifyUI.dropdown_active_bg : (delegate.hovered ? StratifyUI.dropdown_hover_bg :StratifyUI.dropdown_bg);
            border.color: delegate.highlighted ? StratifyUI.dropdown_border : "transparent";
            radius: 0;
        }

    }


    indicator: Text {
        id: indicator;
        x: control.mirrored ? control.leftPadding : control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        text: Fa.Icon.caret_down;
        font.family: properties.fontIcon;
        font.pixelSize: StratifyUI.font_size_base;
        color: StratifyUI.dropdown_caret_color;
        opacity: enabled ? 1 : 0.3
    }


    contentItem: Text {
        leftPadding: control.mirrored && control.indicator ? control.indicator.width + control.spacing : 0
        rightPadding: !control.mirrored && control.indicator ? control.indicator.width + control.spacing : 0

        text: control.displayText
        font: control.font;
        color: properties.fontColor;
        horizontalAlignment: properties.fontHorizontalAlignment;
        verticalAlignment: properties.fontVerticalAlignment;
        elide: Text.ElideRight
        opacity: enabled ? 1 : 0.3

        MouseArea {
            anchors.fill: parent;
            onClicked: {
                popup.visible = !popup.visible;
                control.clicked();
            }
        }

    }

    background: Rectangle {
        color: StratifyUI.dropdown_bg;
        border.color: StratifyUI.dropdown_border;
        border.width: StratifyUI.border_width;
        visible: !control.flat || control.pressed
        radius: StratifyUI.border_radius_base;
    }


    popup: Popup {
        y: control.height - (control.visualFocus ? 0 : 1) + properties.paddingVertical;
        width: control.width;
        implicitHeight: ((count < 4 ? (contentItem.implicitHeight*(count ? count : 1) + properties.paddingVertical*2) : contentItem.implicitHeight*4)) + properties.paddingVertical*2;
        topMargin: properties.paddingVertical;
        bottomMargin: properties.paddingVertical

        contentItem: ListView {
            id: listview
            clip: true
            implicitHeight: properties.fontContainerHeight;
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex
            highlightRangeMode: ListView.ApplyRange
            highlightMoveDuration: 0

            Rectangle {
                z: 10
                parent: listview;
                width: listview.width;
                height: listview.height;
                color: "transparent";
                radius: properties.borderRadius;
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            color: StratifyUI.dropdown_bg;
            radius: properties.borderRadius;
            border.color: StratifyUI.dropdown_border;
        }
    }

}
