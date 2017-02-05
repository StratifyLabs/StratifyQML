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
import "."

ListView {
    property alias style: properties.style;
    property alias span: properties.span;
    property alias properties: properties;

    SProperties {
        id: properties;
    }

    implicitWidth: contentItem.childrenRect.width;
    clip: true;
    spacing: properties.paddingVertical;

    Rectangle {
        id: listViewRect;
        anchors.fill: parent;
        color: "transparent";
        border.color: properties.borderColor;
        border.width: properties.borderWidth;
        radius: properties.borderRadius;
    }
}
