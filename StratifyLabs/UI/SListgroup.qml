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
import "SCustomize.js" as Theme

SList {
    id: base;
    type: "listgroup";
    delegate: listDelegate;
    blockWidth: true;

    implicitHeight: listViewObject.count * (font_size + padding_vertical*5);
    listViewObject.spacing: 0;

    property real active;

    Component {
        id: listDelegate;

        SRoundedRectangle {
            id: base;
            /*
            property bool active: false;

            states: [
                State { when: active;
                    PropertyChanges {
                        target: base;
                        color: Theme.list_group_active_bg;
                        borderColor: Theme.list_group_active_border;
                    }
                    PropertyChanges {
                        target: text;
                        text_color: Theme.list_group_active_color;
                    }
                },
                State { when: !active;
                    PropertyChanges {
                        target: base;
                        color: Theme.list_group_bg;
                        borderColor: Theme.list_group_border;
                    }
                    PropertyChanges {
                        target: text;
                        text_color: Theme.text_color;
                    }
                }
            ]

            transitions: Transition {
                ColorAnimation { property: "color"; duration: 100 }
                ColorAnimation { property: "borderColor"; duration: 100 }
                ColorAnimation { property: "text_color"; duration: 100 }
            }
            */

            topRadius: index == 0 ? Theme.list_group_border_radius : 0;
            bottomRadius: index == (listViewObject.count-1) ? Theme.list_group_border_radius : 0;
            implicitWidth: parent.width;
            implicitHeight: contents.height+2;
            color: Theme.list_group_bg;
            borderColor: Theme.list_group_border;
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
                    color = Theme.list_group_hover_bg;
                }

                onExited: {
                    color = Theme.list_group_bg;
                }

            }
        }

    }
}
