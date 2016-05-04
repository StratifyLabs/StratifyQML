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
    height: contents.childrenRect.height + padding_vertical*2;

    property bool affixBottom: false;
    property bool affixTop: false;
    property bool affixLeft: false;
    property bool affixRight: false;

    anchors.bottom: affixBottom ? parent.bottom : undefined;
    anchors.top: affixTop ? parent.top : undefined;
    anchors.left: affixLeft ? parent.left : undefined;
    anchors.right: affixRight ? parent.right : undefined;
    z: affixBottom | affixTop | affixLeft | affixRight ? 1 : 0;

    onStyleChanged: {
        var items = parseStyle();
        var i;
        for(i=0; i < items.length; i++){
            if( i  > 0 ){
                if((items[i] === "top") && (items[i-1] === "affix") ){
                    affixTop = true;
                }

                if((items[i] === "bottom") && (items[i-1] === "affix") ){
                    affixBottom = true;
                }

                if((items[i] === "left") && (items[i-1] === "affix") ){
                    affixLeft = true;
                }

                if((items[i] === "right") && (items[i-1] === "affix") ){
                    affixRigth = true;right
                }


            }
        }

    }

    Rectangle {
        anchors.fill: parent;
        color: background;
    }

    Item {
        x: padding_horizontal;
        y: padding_vertical;
        id: contents;
        implicitWidth: (parent.width - padding_horizontal*2);
    }
}
