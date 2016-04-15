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

SItem {
    default property alias data: modalContents.data;
    anchors.fill: parent;

    Rectangle {
        anchors.fill: parent;
        color: Qt.rgba(0,0,0,Theme.modal_backdrop_opacity);
        Rectangle {
            anchors.centerIn: parent;
            width: Theme.modal_md > parent.width*0.75 ? parent.width*0.75 : Theme.modal_md;
            height: modalContents.height;
            radius: Theme.panel_border_radius;
            border.color: Theme.modal_header_border_color;

            SColumn {
                y: padding_vertical;
                id: modalContents;
            }
        }

    }
}
