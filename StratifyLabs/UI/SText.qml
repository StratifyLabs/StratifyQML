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

SBaseRectangle {
    id: base;
    property alias text: text.text;
    property alias icon: text.text;
    property alias textObject: text;

    property bool spin: false;
    property bool pulse: false;
    property real pulseSteps: 8;
    property real animationPeriod: 1200;

    type: "text";
    implicitWidth: text.width;
    implicitHeight: fontSize + paddingVertical*3;

    onSpinChanged: {
        if( spin == false ){
            text.rotation = 0;
        }
    }

    signal clicked();

    contents.color: "transparent";
    contents.border.color: "transparent";
    onStyleChanged: {
        var items = parseStyle();
        var i;
        for(i=0; i < items.length; i++){
            if( items[i] === "text-left" ){
                text.horizontalAlignment = Text.AlignLeft;
            } else if( items[i] === "text-right" ){
                text.horizontalAlignment = Text.AlignCenter;
            } else if( items[i] === "text-center" ){
                text.horizontalAlignment = Text.AlignRight;
            } else if( items[i] === "fa" ){
                text.font.family = iconFont;
                text.font.pointSize = fontSize + paddingVertical*2;
            } else if( items[i] === "bold" ){
                text.font.weight = Font.Bold;
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
        Text {
            id: text;
            anchors.verticalCenter: parent.verticalCenter;
            verticalAlignment: Text.AlignVCenter;
            leftPadding: paddingHorizontal;
            rightPadding: paddingHorizontal;
            color: textColor;
            font.pointSize: fontSize;
            font.family: textFont;
            font.weight: Font.Light;
            opacity: textOpacity;


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
    ]

    MouseArea {
        anchors.fill: parent;
        hoverEnabled: true;
        onEntered: startHover();
        onExited: stopHover();
        onClicked: base.clicked();
    }

}
