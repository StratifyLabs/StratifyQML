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
import QtQuick.Window 2.2

import StratifyLabs.UI 1.0

SList {
    id: base;
    type: "listgroup";
    delegate: listDelegate;
    blockWidth: true;

    implicitHeight: listViewObject.count * (fontSize + paddingVertical*5);
    listViewObject.spacing: -2*Screen.devicePixelRatio;

    property real active;

    Component {
        id: listDelegate;

        SRoundedRectangle {
            id: base;
            topRadius: index == 0 ? theme.list_group_border_radius : 0;
            bottomRadius: index == (listViewObject.count-1) ? theme.list_group_border_radius : 0;
            implicitWidth: parent.width;
            implicitHeight: contents.height-pixelRatio;
            color: theme.list_group_bg;
            borderColor: theme.list_group_border;
            SContainer {
                id: contents;
                SText {
                    id: text;
                    blockWidth: true;
                    text: model.text;
                }
            }

            MouseArea {
                anchors.fill: parent;
                hoverEnabled: true;

                onEntered: {
                    color = theme.list_group_hover_bg;
                }

                onExited: {
                    color = theme.list_group_bg;
                }

            }
        }

    }
}
