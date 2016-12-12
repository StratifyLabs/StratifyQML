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
import "."

SBaseRectangle {
    id: baseRectangleText;

    property string icon;
    property string text;
    property alias textObject: rectangleText;
    property bool hideTextOnSm: false;
    property bool spin: false;
    property bool pulse: false;
    property real pulseSteps: 8;
    property real animationPeriod: 1200;
    property alias iconObject: rectangleIcon;


    //size the rectangle based on the size of the text box
    implicitHeight: fontContainerHeight;
    implicitWidth: baseRectangleTextText.width;

    onSpinChanged: {
        if( spin == false ){
            rectangleIcon.rotation = 0;
        }
    }


    onStyleChanged: {
        var items = style.split(" ");
        for(var i=0; i < items.length; i++){
            if( items[i] === "text-left" ){
                textObject.anchors.centerIn = undefined;
                textObject.anchors.left = baseRectangleTextText.parent.left;
            } else if( items[i] === "text-right" ){
                textObject.horizontalAlignment = Text.AlightRight;
            } else if( items[i] === "text-center" ){
                textObject.horizontalAlignment = Text.AlignHCenter;
            } else if( items[i] === "bold" ){
                textObject.font.weight = Font.Bold;
            } else if( items[i] === "text-hide-sm"){
                hideTextOnSm = true;
            } else if( items[i] === "fa-spin" ){
                pulse = false;
                spin = true;
            } else if( items[i] === "fa-pulse" ){
                spin = false;
                pulse = true;
            }
        }
    }


    contents.data: [

        Row {
            id: baseRectangleTextText;
            property alias textObject: rectangleText;
            anchors.centerIn: parent;

            leftPadding: paddingHorizontal;
            rightPadding: paddingHorizontal;
            bottomPadding: paddingVertical;
            topPadding: paddingVertical;
            spacing: paddingHorizontal/4;

            Text {
                id: rectangleIcon;
                color: enabled ? textColor : theme.text_muted;
                text: icon;
                font.pointSize: fontSize*1.15;
                font.family: iconFont;
                font.weight: Font.Light;
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignVCenter;
                height: rectangleText.height;

                RotationAnimation on rotation {
                    loops: Animation.Infinite;
                    paused: !spin;
                    from: 0;
                    to: 360;
                    duration: animationPeriod;
                }

                Timer {
                    id: pulseTimer;
                    running: pulse;
                    repeat: true;
                    interval: animationPeriod/pulseSteps;
                    onTriggered: {
                        rectangleIcon.rotation += 360/pulseSteps;
                    }
                }
            }

            Text {
                id: rectangleText;
                color: enabled ? textColor : theme.text_muted;
                text: baseRectangleText.text;
                font.pointSize: fontSize;
                font.family: textFont;
                font.weight: Font.Light;
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignVCenter;
                visible: ((icon !== "") && (hideTextOnSm)) ? !sm : true;
            }
        }

    ]
}
