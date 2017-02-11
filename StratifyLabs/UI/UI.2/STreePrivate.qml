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

TreeView {
    id: root;

    property alias attr: attr;

    property alias striped: root.alternatingRowColors;
    property bool hover: false;
    property bool bordered: false;

    SAttributes {
        id: attr;
        blockWidth:  true;
        type: "tree";
        fontWeight: Font.Light;
        borderColor: Qt.darker(STheme.body_bg, 1.1);

        onStyleChanged: {
            var items = parseStyle();
            for(var i = 0; i < items.length; i++){
                if( items[i] === "tree-striped" ){
                    striped = true;
                } else if( items[i] === "tree-condensed" ){
                    attr.paddingVertical = STheme.padding_small_vertical;
                } else if( items[i] === "tree-bordered" ){
                    bordered = true;
                }
            }
        }

    }

    // \todo need to apply contextual shading to rows
    // \todo need to replace scroll bars with the scroll bar in STextBox

    implicitHeight: childrenRect.height;
    width: parent.width;

    property real selected: -1;
    property var currentIndex;

    alternatingRowColors: false;
    backgroundVisible: false;


    style: TreeViewStyle {

        backgroundColor: "transparent";
        frame: Rectangle {
            color: "transparent";
            border.color: attr.borderColor;
            border.width: bordered ? 1 : 0;
        }


        scrollBarBackground: Rectangle {
            implicitWidth: 8
            color: "transparent";
        }


        branchDelegate: Item{
            anchors.centerIn: parent;
            width: attr.fontSize + attr.paddingHorizontal*3;
            height: attr.fontSize + attr.paddingVertical*3;

            Text {
                id: branchText;
                anchors.right: parent.right;
                anchors.verticalCenter: parent.verticalCenter;
                color: attr.fontColor;
                font.family: attr.fontIcon;
                text: Fa.Icon.chevron_right;
                rotation: styleData.isExpanded ? 90 : 0;
                state: styleData.isExpanded ? "expanded" : "collapsed";
                states: [
                    State {
                        name: "expanded";
                        PropertyChanges { target: branchText; rotation: 90; }

                    },
                    State {
                        name: "collapsed";
                        PropertyChanges { target: branchText; rotation: 0; }
                    }
                ]


                transitions: Transition {
                    RotationAnimation { duration: 200; direction: RotationAnimation.Shortest; }
                }

            }

            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if( styleData.isExpanded ){
                        root.collapse(styleData.index);
                        branchText.state = "collapsed";
                    } else {
                        root.expand(styleData.index);
                        branchText.state = "expanded";
                    }
                }
            }

        }
        decrementControl: Item{}
        incrementControl: Item{}
        handleOverlap: 0;

        handle: Rectangle {
            implicitWidth: 8;
            color: STheme.gray_lighter;
            radius: width > height ? height/2 : width/2;
        }

    }

    clip: true;

    itemDelegate: Text {
        verticalAlignment: Text.AlignVCenter;
        leftPadding: attr.paddingHorizontal;
        rightPadding: attr.paddingHorizontal;
        topPadding: attr.paddingVertical;
        bottomPadding: attr.paddingVertical;
        color: attr.fontColor;
        font.pointSize: attr.fontSize;
        font.family: attr.fontText;
        font.weight: attr.fontWeight;
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
        color: (styleData.selected) ? Qt.darker(STheme.body_bg, 1.02 + hovered*0.05) : Qt.darker(STheme.body_bg, 1.0 + hovered*0.05);

        height: attr.fontSize + attr.paddingVertical*3;

        Rectangle {
            width: parent.width;
            height: 1;
            color: attr.borderColor;
            border.color: attr.borderColor;
            anchors.bottom: parent.bottom;
            visible: styleData.row !== (root.rowCount -1);
        }

        /*
            MouseArea {
                anchors.fill: parent;
                hoverEnabled: true;
                onEntered: {
                    hovered = true && root.hover;
                }
                onExited: hovered = false;
                onClicked: {
                    root.rowClicked();
                    root.selected = styleData.row;
                }
            }
            */

    }

}


