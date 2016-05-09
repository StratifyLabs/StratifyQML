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
    type: "container";
    default property alias data: contents.data;
    property string background: "transparent";
    width: parent.width;
    height: fillHeight ? parent.height: contents.childrenRect.height + padding_vertical*2;

    Rectangle {
        anchors.fill: parent;
        color: background;
    }

    Item {
        x: padding_horizontal;
        y: padding_vertical;
        height: fillHeight ? parent.height - padding_vertical*2: undefined;
        id: contents;
        width: (parent.width - padding_horizontal*2);
    }
}
