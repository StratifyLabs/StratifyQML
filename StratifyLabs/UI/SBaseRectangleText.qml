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

SBaseRectangle {
    id: baseRectangleText;

    property string icon;
    property string text;
    property alias textObject: baseRectangleTextText;
    property bool hideTextOnSm: true;

    property alias iconObject: rectangleIcon;

    //size the rectangle based on the size of the text box
    implicitHeight: font_size + Theme.padding_base_vertical*3;
    implicitWidth: baseRectangleTextText.width;

    onStyleChanged: {
        var items = style.split(" ");
        for(var i=0; i < items.length; i++){
            if( items[i] === "text-left" ){
                baseRectangleTextText.anchors.centerIn = undefined;
                baseRectangleTextText.anchors.left = baseRectangleTextText.parent.left;
            } else if( items[i] === "text-right" ){
                baseRectangleTextText.horizontalAlignment = Text.AlightRight;
            } else if( items[i] === "text-center" ){
                baseRectangleTextText.horizontalAlignment = Text.AlignHCenter;
            } else if( items[i] === "bold" ){
                baseRectangleTextText.font.weight = Font.Bold;
            }
        }
    }


    contents.data: [

        Row {
            id: baseRectangleTextText;
            anchors.centerIn: parent;

            leftPadding: padding_horizontal;
            rightPadding: padding_horizontal;
            bottomPadding: padding_vertical;
            topPadding: padding_vertical;
            spacing: Theme.padding_base_horizontal/4;

            Text {
                id: rectangleIcon;
                color: text_color;
                text: icon;
                font.pointSize: font_size*1.15;
                font.family: fontawesome.name;
                font.weight: Font.Light;
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignVCenter;
                height: rectangleText.height;
            }

            Text {
                id: rectangleText;
                color: text_color;
                text: baseRectangleText.text;
                font.pointSize: font_size;
                font.family: openSansLight.name;
                font.weight: Font.Light;
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignVCenter;
                visible: (icon !== "") && (hideTextOnSm) ? !sm : true;
            }
        }

    ]
}
