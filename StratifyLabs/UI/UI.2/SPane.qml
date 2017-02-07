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
import StratifyLabs.UI 2.0

Flickable {
    id: control;
    property alias style: properties.style;
    property alias span: properties.span;
    property alias properties: properties;

    SProperties {
        id: properties;
        fillWidth: true;
        fillHeight: true;
    }

    clip: true;
    width: parent ? (properties.fillWidth ? parent.width : undefined) : undefined;
    height: parent ? (properties.fillHeight ? parent.height : undefined) : undefined;

    implicitWidth: contentWidth;
    implicitHeight: contentHeight;

    //if child has "block" set, width will bind
    contentWidth: ((contentItem.children[0].properties !== undefined) && (contentItem.children[0].properties.fillWidth === true)) ? control.width : contentItem.childrenRect.width;
    contentHeight: (contentItem.children[0].properties !== undefined) && (contentItem.children[0].properties.fillHeight === true) ? control.height : contentItem.childrenRect.height;

}
