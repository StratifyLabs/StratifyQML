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

import "."

SList {
    id: control;
    properties.type: "listgroup";
    delegate: listDelegate;

    implicitHeight: count * (properties.fontContainerHeight);
    spacing: -2*Screen.devicePixelRatio;

    properties.backgroundColorHover: StratifyUI.list_group_hover_bg;
    properties.backgroundColor: StratifyUI.list_group_bg;
    properties.borderColor: StratifyUI.list_group_border;

    property real active;

    Component {
        id: listDelegate;

        SRoundedRectangle {
            id: base;
            topRadius: index == 0 ? properties.borderRadius : 0;
            bottomRadius: index == (control.count-1) ? properties.borderRadius : 0;
            implicitWidth: properties.blockWidth ? parent.width : (text.width + properties.paddingHorizontal*2);
            implicitHeight: properties.fontContainerHeight;
            color: properties.backgroundColor;
            borderColor: properties.borderColor;
            SContainer {
                id: contents;
                SText {
                    id: text;
                    properties.blockWidth: true;
                    text: model.text;
                }
            }

            MouseArea {
                anchors.fill: parent;
                hoverEnabled: true;

                onEntered: {
                    color = properties.backgroundColorHover;
                }

                onExited: {
                    color = properties.backgroundColor;
                }

            }
        }
    }
}
