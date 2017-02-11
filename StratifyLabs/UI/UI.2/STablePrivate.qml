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
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import StratifyLabs.UI 2.0

TableView {
    id: root;

    property alias attr: attr;
    property alias striped: root.alternatingRowColors;
    property bool hover: false;
    property bool bordered: false;
    property bool highlightSelectedRow: false;
    property bool highlightSelectedItem: false;

    signal rowClicked();


    SAttributes {
        id: attr;
        type: "table";

        borderColor: Qt.darker(STheme.body_bg, 1.1);
        blockWidth:  true;

        onStyleChanged: {
            var items = parseStyle();
            for(var i = 0; i < items.length; i++){
                if( items[i] === "table-striped" ){
                    striped = true;
                } else if( items[i] === "table-condensed" ){
                    paddingVertical = Qt.binding( function(){ return STheme.padding_small_vertical; } );
                } else if( items[i] === "table-hover" ){
                    hover = true;
                } else if( items[i] === "table-bordered" ){
                    bordered = true;
                }
            }
        }
    }

    // \todo need to apply contextual shading to rows
    // \todo need to replace scroll bars with the scroll bar in STextBox

    alternatingRowColors: false;
    backgroundVisible: false;

    style: TableViewStyle {
        backgroundColor: attr.backgroundColor;
        frame: Item{}
        scrollBarBackground: Item{}
        corner: Item{}
        decrementControl: Item{}
        incrementControl: Item{}
        handleOverlap: 0;
        handle: Rectangle {
            implicitWidth: 8;
            color: STheme.gray_lighter;
            radius: width/2;
        }
        textColor: attr.fontColor;
    }


    clip: true;

    itemDelegate: Text {
        verticalAlignment: attr.fontVerticalAlignment;
        leftPadding: attr.paddingHorizontal;
        rightPadding: attr.paddingHorizontal;
        topPadding: attr.paddingVertical;
        bottomPadding: attr.paddingVertical;
        color: attr.fontColor;
        font.pointSize: attr.fontSize;
        font.family: attr.fontText;
        font.weight: Font.Light;
        text: styleData.value;
        Rectangle {
            color: "transparent";
            anchors.fill: parent;
            border.width: bordered ? 1 : 0;
            border.color: attr.borderColor;
        }
    }

    headerDelegate: Text {
        verticalAlignment: attr.fontVerticalAlignment;
        leftPadding: attr.paddingHorizontal;
        rightPadding: attr.paddingHorizontal;
        topPadding: attr.paddingVertical;
        bottomPadding: attr.paddingVertical;
        color: STheme.gray_base;
        font.pointSize: attr.fontSize;
        font.family: attr.fontText;
        font.weight: Font.Bold;
        text: styleData.value;

        Rectangle {
            anchors.fill: parent;
            color: STheme.body_bg;
            z: -1;
        }

        Rectangle {
            color: "transparent";
            anchors.fill: parent;
            border.width: bordered ? 1 : 0;
            border.color: attr.borderColor;
        }

        Rectangle {
            width: parent.width;
            height: 2;
            color: attr.borderColor;
            border.color: attr.borderColor;
            anchors.bottom: parent.bottom;
        }
    }

    rowDelegate: Rectangle {

        property bool hovered;
        color: styleData.alternate ? Qt.darker(STheme.body_bg, 1.02 + hovered*0.05 + (styleData.selected && highlightSelectedRow)*0.08) : Qt.darker(STheme.body_bg, 1.0 + hovered*0.05 + (styleData.selected && highlightSelectedRow)*0.08);

        height: attr.fontContainerHeight;

        Rectangle {
            width: parent.width;
            height: 1;
            color: attr.borderColor;
            border.color: attr.borderColor;
            anchors.bottom: parent.bottom;
            visible: styleData.row !== (root.rowCount - 1);
        }


        MouseArea {
            anchors.fill: parent;
            hoverEnabled: true;
            onEntered: {
                hovered = true && root.hover;
            }
            onExited: hovered = false;
            onClicked: {
                root.selection.clear();
                root.selection.select(styleData.row, styleData.row);
                root.currentRow = styleData.row;
                root.rowClicked();
            }
        }
    }
}


