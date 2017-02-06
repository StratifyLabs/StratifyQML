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

Item {
    id: control;

    property string icon;
    property string label;

    property alias properties: properties;
    property alias style: properties.style;
    property alias span: properties.span;

    property bool spin: false;
    property bool pulse: false;
    property real pulseSteps: 8;
    property real animationPeriod: 1200;

    property real verticalAlignment: properties.fontHorizontalAlignment;
    property real horizontalAlignment: properties.fontVerticalAlignment;

    implicitWidth: icon.implicitWidth + label.implicitWidth + row.spacing;
    implicitHeight: icon.implicitHeight + label.implicitHeight;

    SProperties {
        id: properties;
    }

    Row {
        id: row;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.horizontalCenter: parent.horizontalCenter;
        spacing: properties.paddingHorizontal/4;

        Text {
            id: icon;
            anchors.verticalCenter: parent.verticalCenter;
            text: control.icon;
            font.family: properties.fontIcon;
            font.pointSize: properties.fontSize*1.2;
            color: enabled ? properties.fontColor : properties.fontColorMuted;

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
                    icon.rotation += 360/pulseSteps;
                }
            }
        }

        Text {
            id: label;
            anchors.verticalCenter: parent.verticalCenter;
            text: control.label;
            font.family: properties.fontText;
            font.pointSize: properties.fontSize;
            color: enabled ? properties.fontColor : properties.fontColorMuted;
        }
    }


}
