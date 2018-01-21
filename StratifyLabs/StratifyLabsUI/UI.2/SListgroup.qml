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
import StratifyLabs.UI 2.0

SList {
    id: control;
    delegate: listDelegate;

    implicitHeight: count * (attr.fontContainerHeight);
    spacing: -2*Screen.devicePixelRatio;

    attr.colorHovered: STheme.list_group_hover_bg;
    attr.color: STheme.list_group_bg;
    attr.borderColor: STheme.list_group_border;
    attr.type: "listgroup";

    property real active;

    Component {
        id: listDelegate;

        SRoundedRectangle {
            id: base;
            topRadius: index == 0 ? attr.borderRadius : 0;
            bottomRadius: index == (control.count-1) ? attr.borderRadius : 0;
            implicitWidth: attr.blockWidth ? parent.width : (text.width + attr.paddingHorizontal*2);
            implicitHeight: attr.fontContainerHeight;
            color: attr.color;
            borderColor: attr.borderColor;
            SContainer {
                id: contents;
                SText {
                    id: text;
                    attr.blockWidth: true;
                    text: model.text;
                }
            }

            MouseArea {
                anchors.fill: parent;
                hoverEnabled: true;

                onEntered: {
                    color = attr.colorHovered;
                }

                onExited: {
                    color = attr.color;
                }

            }
        }
    }
}
