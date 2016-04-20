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
import "Fa-4.5.0.js" as Fa

SItem {
    id: base;
    type: "alert";
    property alias text: alertText.text;
    property real padding_vertical: Theme.padding_base_vertical;
    property real padding_horizontal: Theme.padding_base_horizontal;
    property real font_size: Theme.font_size_base;

    property bool dismissible: true;
    property bool dismissed: false;

    onOpacityChanged: {
        if( opacity < 0.01 ){
            visible = false;
        } else if ( opacity > 0.01 ){
            visible = true;
        }
    }

    states: [
        State { when: dismissed;
            PropertyChanges {   target: base; opacity: 0.0    }
        },
        State { when: !dismissed;
            PropertyChanges {   target: base; opacity: 1.0    }
        }
    ]

    transitions: Transition {
        NumberAnimation { property: "opacity"; duration: 150 }
    }

    property string bg_color: Theme.alert_info_bg;
    property string text_color: Theme.alert_info_text;
    property string border_color: Theme.alert_info_border;

    implicitWidth: parent.width;
    implicitHeight: alertRectangle.height;

    onStyleChanged: {
        var items = parseStyle();
        for(var i = 0; i < items.length; i++){
            if( items[i] === "danger" ){
                bg_color = Theme.alert_danger_bg;
                text_color = Theme.alert_danger_text;
                border_color = Theme.alert_danger_border;
            } else if( items[i] === "success" ){
                bg_color = Theme.alert_success_bg;
                text_color = Theme.alert_success_text;
                border_color = Theme.alert_success_border;
            } else if( items[i] === "info" ){
                bg_color = Theme.alert_info_bg;
                text_color = Theme.alert_info_text;
                border_color = Theme.alert_info_border;
            } else if( items[i] === "warning" ){
                bg_color = Theme.alert_warning_bg;
                text_color = Theme.alert_warning_text;
                border_color = Theme.alert_warning_border;
            }
        }
    }

    Rectangle {
        id: alertRectangle;

        implicitWidth: parent.width;
        implicitHeight: alertText.height;

        color: bg_color;
        border.color: border_color;
        border.width: 1;
        radius: Theme.alert_border_radius;

        Text {
            id: alertText;
            anchors.top: parent.top;
            anchors.left: parent.left;
            width: parent.width-2 - alertDismiss.width;
            topPadding: padding_vertical;
            bottomPadding: padding_vertical;
            leftPadding: padding_horizontal;
            text: "";
            color: text_color;
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
            font.pointSize: font_size;
            font.family: openSansLight.name;
            font.weight: Font.Light;
            verticalAlignment: Text.AlignVCenter;
        }

        Text {
            id: alertDismiss;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.right: parent.right;
            topPadding: padding_vertical;
            bottomPadding: padding_vertical;
            rightPadding: padding_horizontal;
            text: Fa.Icon.times;
            color: Qt.lighter(Theme.text_color, 3.0);
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
            font.pointSize: font_size;
            font.family: fontawesome.name;
            visible: dismissible;
            verticalAlignment: Text.AlignVCenter;

            MouseArea {
                anchors.fill: parent;
                hoverEnabled: true;
                onClicked: {
                    //dismiss
                    dismissed = true;
                }

                onEntered: {
                    alertDismiss.color = Theme.text_color;
                }

                onExited: {
                    alertDismiss.color = Qt.lighter(Theme.text_color, 3.0);
                }

            }
        }



    }

}
