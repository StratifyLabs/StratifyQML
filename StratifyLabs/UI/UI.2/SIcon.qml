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

Item {
    id: control;

    property string icon;
    property string label;

    property alias attr: attr;
    property alias style: attr.style;
    property alias span: attr.span;

    property real verticalAlignment: attr.fontHorizontalAlignment;
    property real horizontalAlignment: attr.fontVerticalAlignment;

    function resetSpin() {
        icon.rotation = 0
    }

    implicitWidth: icon.implicitWidth + (label.implicitWidth*label.visible) + row.spacing;
    implicitHeight: Math.max(icon.implicitHeight, label.implicitHeight);

    SIconAttributes {
        id: attr;
        onStyleChanged:{
            onStyleChanged: {
                var items = parseStyle();
                for(var i = 0; i < items.length; i++){
                    if( (items[i] === "icon-spin") || (items[i] === "fa-spin") ){
                        spin = true;
                    } else if( (items[i] === "icon-pulse") || (items[i] === "fa-pulse") ){
                        pulse = true;
                    }
                }
            }
        }
    }

    Row {
        id: row;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.horizontalCenter: parent.horizontalCenter;
        spacing: attr.paddingHorizontal/4;

        Text {
            id: icon;
            anchors.verticalCenter: parent.verticalCenter;
            text: control.icon;
            font.family: attr.fontIcon;
            font.pointSize: attr.fontSize*1.2;
            font.weight: attr.fontWeight;
            color: enabled ? attr.fontColor : attr.fontColorMuted;

            RotationAnimation on rotation {
                loops: Animation.Infinite;
                paused: !attr.spin;
                from: 0;
                to: 360;
                duration: attr.animationPeriod;
            }

            Timer {
                id: pulseTimer;
                running: attr.pulse;
                repeat: true;
                interval: attr.animationPeriod/attr.pulseSteps;
                onTriggered: {
                    icon.rotation += 360/attr.pulseSteps;
                }
            }
        }

        Text {
            id: label;
            anchors.verticalCenter: parent.verticalCenter;
            text: control.label;
            font.italic: attr.fontItalic;
            font.family: attr.fontText;
            font.pointSize: attr.fontSize;
            font.weight: attr.fontWeight;
            color: enabled ? attr.fontColor : attr.fontColorMuted;
            visible: !(STheme.isScreenSm && attr.fontHideSm);
        }
    }


}
