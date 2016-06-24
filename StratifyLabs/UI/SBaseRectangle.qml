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

SItem {
    id: baseRectangle;
    property alias contents: contents;
    type: "base";
    blockWidth: false;

    Rectangle {
        id: contents;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.verticalCenter: parent.verticalCenter;
        implicitWidth: parent.width;
        implicitHeight: parent.height;
        width: (blockWidth == true) ? parent.width : parent.implicitWidth;
        radius: baseRectangle.radius;
        border.color: enabled ? baseRectangle.borderColor : theme.gray_lighter;
        color: enabled ? baseRectangle.backgroundColor : theme.gray_lighter;
        clip: true;
    }

    onStyleChanged: {
        var items = parseStyle();
        for(var i = 0; i < items.length; i++){
            if( items[i] === "block" ){
                blockWidth = true;
            } else if( items[i] === "left" ){
                contents.anchors.horizontalCenter = undefined;
                contents.anchors.right = undefined;
                contents.anchors.left = baseRectangle.left;
            } else if( items[i] === "right" ){
                contents.anchors.horizontalCenter = undefined;
                contents.anchors.left = undefined;
                contents.anchors.right = baseRectangle.right;
            } else if( items[i] === "center" ){
                contents.anchors.right = undefined;
                contents.anchors.left = undefined;
                contents.anchors.horizontalCenter = baseRectangle.horizontalCenter;
            } else if( items[i] === "top" ){
                contents.anchors.verticalCenter = undefined;
                contents.anchors.bottom = undefined;
                contents.anchors.top = baseRectangle.top;
            } else if( items[i] === "bottom" ){
                contents.anchors.top = undefined;
                contents.anchors.verticalCenter = undefined;
                contents.anchors.bottom = baseRectangle.bottom;
            } else if( items[i] === "middle" ){
                contents.anchors.top = undefined;
                contents.anchors.bottom = undefined;
                contents.anchors.verticalCenter = baseRectangle.verticalCenter;
            }
        }
    }
}
