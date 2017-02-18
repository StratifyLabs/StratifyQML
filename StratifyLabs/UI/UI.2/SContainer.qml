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

Rectangle {
    id: control;
    property alias style: attr.style;
    property alias span: attr.span;
    property alias attr: attr;
    property string name;

    default property alias data: contents.data;

    width: parent ? (attr.fillWidth ? parent.width : undefined) : undefined;
    height: parent ? (attr.fillHeight ? parent.height : undefined) : undefined;

    implicitWidth: contents.implicitWidth + attr.paddingHorizontal*2;
    implicitHeight: contents.implicitHeight + attr.paddingVertical*2;
    color: "transparent";


    Item {
        id: contents;
        x: attr.paddingHorizontal;
        y: attr.paddingVertical;
        parent: control;

        height: parent.height === undefined ? undefined : parent.height - attr.paddingVertical*2;
        width: parent.width === undefined ? undefined : parent.width - attr.paddingHorizontal*2;

        implicitWidth: childrenRect.width;
        implicitHeight: childrenRect.height;
    }


    SSizeAttributes {
        id: attr;
        type: "container";
        fillWidth: true;
    }

}
