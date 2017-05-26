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
    property alias attr: attr;
    property alias style: attr.style;
    property alias span: attr.span;

    //Legacy 1.0 interfacing
    property alias text: control.currentText;
    property alias activeText: control.currentText;
    signal clicked();
    signal itemClicked();
    onActivated: itemClicked();

    SAttributes {
        id: attr;
        blockWidth: true;

        property real numberVisible: 4;

        fontColorSelected: STheme.dropdown_active_color;
        fontColorHovered: STheme.dropdown_hover_color;
        color: STheme.dropdown_active_bg;
        colorHovered: STheme.dropdown_hover_bg;
        backgroundColor: STheme.dropdown_bg;
        borderWidth: STheme.border_width;
    }

    implicitWidth: contentItem.implicitWidth + attr.paddingHorizontal*2;
    implicitHeight: attr.fontContainerHeight;

    baselineOffset: contentItem.y + contentItem.baselineOffset;

    font.family: attr.fontText;
    font.pointSize: attr.fontSize;
    font.weight: attr.fontWeight;

    spacing: attr.paddingVertical;
    topPadding: attr.paddingVertical;
    bottomPadding: attr.paddingVertical;
    leftPadding: attr.paddingHorizontal;
    rightPadding: attr.paddingHorizontal;

    delegate: ItemDelegate {
        id: delegate;
        width: control.popup.width
        text: control.textRole ? (Array.isArray(control.model) ? modelData[control.textRole] : model[control.textRole]) : modelData

        contentItem: Text {
            leftPadding: control.mirrored ? (control.indicator ? control.indicator.width : 0) + control.spacing : 0
            rightPadding: !control.mirrored ? (control.indicator ? control.indicator.width : 0) + control.spacing : 0

            text: delegate.text
            font: control.font;
            color: delegate.highlighted ? attr.fontColorSelected : (delegate.hovered ? attr.fontColorHovered : attr.fontColor);
            elide: Text.ElideRight
            visible: delegate.text
            horizontalAlignment: attr.fontHorizontalAlignment;
            verticalAlignment: attr.fontVerticalAlignment;
        }


        highlighted: control.highlightedIndex == index;
        hoverEnabled: control.hoverEnabled;

        background: Rectangle {
            color: delegate.highlighted ? attr.color : (delegate.hovered ? attr.colorHovered : attr.backgroundColor);
            border.color: delegate.highlighted ? STheme.dropdown_border : "transparent";
            radius: 0;
        }

    }


    indicator: Text {
        id: indicator;
        x: control.mirrored ? control.leftPadding : control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        text: Fa.Icon.caret_down;
        font.family: attr.fontIcon;
        font.pointSize: STheme.font_size_base;
        color: STheme.dropdown_caret_color;
        opacity: enabled ? 1 : 0.3
    }


    contentItem: Text {
        leftPadding: control.mirrored && control.indicator ? control.indicator.width + control.spacing : 0
        rightPadding: !control.mirrored && control.indicator ? control.indicator.width + control.spacing : 0

        text: control.displayText
        font: control.font;
        color: attr.fontColor;
        horizontalAlignment: attr.fontHorizontalAlignment;
        verticalAlignment: attr.fontVerticalAlignment;
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
        color: attr.backgroundColor;
        border.color: STheme.dropdown_border;
        border.width: STheme.border_width;
        visible: !control.flat || control.pressed
        radius: STheme.border_radius_base;
    }


    popup: Popup {
        y: control.height - (control.visualFocus ? 0 : 1) + attr.paddingVertical;
        width: control.width;
        implicitHeight: ((count < attr.numberVisible ? (contentItem.implicitHeight*(count ? count : 1) + attr.paddingVertical*2) : contentItem.implicitHeight*attr.numberVisible)) + attr.paddingVertical*2;
        topMargin: attr.paddingVertical;
        bottomMargin: attr.paddingVertical

        contentItem: ListView {
            id: listview
            clip: true
            implicitHeight: attr.fontContainerHeight;
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
                radius: attr.borderRadius;
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            color: STheme.dropdown_bg;
            radius: attr.borderRadius;
            border.color: STheme.dropdown_border;
        }
    }

}
