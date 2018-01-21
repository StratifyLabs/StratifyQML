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
import StratifyLabs.UI 1.0

SItem {
    id: base;
    type: "table";

    default property alias data: tableViewObject.data;
    property alias table_object: tableViewObject;
    property alias contents: tableViewObject;
    property alias model: tableViewObject.model;
    property alias striped: tableViewObject.alternatingRowColors;
    property bool hover: false;
    property bool bordered: false;
    property color borderColor: Qt.darker(theme.body_bg, 1.1);
    property bool highlightSelectedRow: false;
    property bool highlightSelectedItem: false;

    signal rowClicked();

    onStyleChanged: {
        var items = parseStyle();
        for(var i = 0; i < items.length; i++){
            if( items[i] === "table-striped" ){
                striped = true;
            } else if( items[i] === "table-condensed" ){
                paddingVertical = theme.padding_small_vertical;
            } else if( items[i] === "table-hover" ){
                hover = true;
            } else if( items[i] === "table-bordered" ){
                bordered = true;
            }
        }
    }

    // \todo need to apply contextual shading to rows
    // \todo need to replace scroll bars with the scroll bar in STextBox

    implicitHeight: fillHeight ? parent.height: tableViewObject.childrenRect.height;
    width: parent.width;
    blockWidth:  true;
    TableView {
        id: tableViewObject;

        width: parent.width;
        height: fillHeight ? parent.height : undefined;

        alternatingRowColors: false;
        backgroundVisible: false;

        style: TableViewStyle {

            backgroundColor: "transparent";
            frame: Rectangle {
                color: "transparent";
                border.color: borderColor;
                border.width: bordered ? 1 : 0;
            }


            scrollBarBackground: Rectangle {
                implicitWidth: 8
                color: "transparent";
            }

            decrementControl: Item{}
            incrementControl: Item{}
            handleOverlap: 0;

            handle: Rectangle {
                implicitWidth: 8;
                color: theme.gray_lighter;
                radius: width/2;
            }

        }

        clip: true;

        itemDelegate: Text {
            verticalAlignment: Text.AlignVCenter;
            leftPadding: paddingHorizontal;
            rightPadding: paddingHorizontal;
            topPadding: paddingVertical;
            bottomPadding: paddingVertical;
            color: textColor;
            font.pointSize: fontSize;
            font.family: textFont;
            font.weight: Font.Light;
            text: styleData.value;
            Rectangle {
                color: "transparent";
                anchors.fill: parent;
                border.width: bordered ? 1 : 0;
                border.color: borderColor;
            }
        }

        headerDelegate: Text {
            verticalAlignment: Text.AlignVCenter;
            leftPadding: paddingHorizontal;
            rightPadding: paddingHorizontal;
            topPadding: paddingVertical;
            bottomPadding: paddingVertical;
            color: theme.gray_base;
            font.pointSize: fontSize;
            font.family: textFont;
            font.weight: Font.Bold;
            text: styleData.value;

            Rectangle {
                anchors.fill: parent;
                color: theme.body_bg;
                z: -1;
            }

            Rectangle {
                color: "transparent";
                anchors.fill: parent;
                border.width: bordered ? 1 : 0;
                border.color: borderColor;
            }

            Rectangle {
                width: parent.width;
                height: 2;
                color: borderColor;
                border.color: borderColor;
                anchors.bottom: parent.bottom;
            }
        }

        rowDelegate: Rectangle {

            property bool hovered;
            color: styleData.alternate ? Qt.darker(theme.body_bg, 1.02 + hovered*0.05 + (styleData.selected && highlightSelectedRow)*0.08) : Qt.darker(theme.body_bg, 1.0 + hovered*0.05 + (styleData.selected && highlightSelectedRow)*0.08);

            height: fontSize + paddingVertical*3;

            Rectangle {
                width: parent.width;
                height: 1;
                color: borderColor;
                border.color: borderColor;
                anchors.bottom: parent.bottom;
                visible: styleData.row !== (tableViewObject.rowCount -1);
            }

            MouseArea {
                anchors.fill: parent;
                hoverEnabled: true;
                onEntered: {
                    hovered = true && base.hover;
                }
                onExited: hovered = false;
                onClicked: {
                    tableViewObject.selection.clear();
                    tableViewObject.selection.select(styleData.row, styleData.row);
                    tableViewObject.currentRow = styleData.row;
                    base.rowClicked();
                }
            }
        }

    }

}


