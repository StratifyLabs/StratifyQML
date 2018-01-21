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
import StratifyLabs.UI 1.0

SItem {
    id: base;
    type: "alert";

    default property alias data: contents.data;
    property alias text: alertText.text;

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


    implicitWidth: parent.width;
    implicitHeight: alertRectangle.height;

    onStyleChanged: {
        var items = parseStyle();
        for(var i = 0; i < items.length; i++){
            if( items[i] === "alert-danger" ){
                backgroundColor = theme.alert_danger_bg;
                textColor = theme.alert_danger_text;
                borderColor = theme.alert_danger_border;
            } else if( items[i] === "alert-success" ){
                backgroundColor = theme.alert_success_bg;
                textColor = theme.alert_success_text;
                borderColor = theme.alert_success_border;
            } else if( items[i] === "alert-info" ){
                backgroundColor = theme.alert_info_bg;
                textColor = theme.alert_info_text;
                borderColor = theme.alert_info_border;
            } else if( items[i] === "alert-warning" ){
                backgroundColor = theme.alert_warning_bg;
                textColor = theme.alert_warning_text;
                borderColor = theme.alert_warning_border;
            }
        }
    }

    Rectangle {
        id: alertRectangle;
        implicitWidth: parent.width;
        implicitHeight: contents.height;
        color: backgroundColor;
        border.color: borderColor;
        border.width: 1;
        radius: theme.alert_border_radius;

        SContainer {
            id: contents;
            Text {
                id: alertText;
                anchors.top: parent.top;
                anchors.left: parent.left;
                width: parent.width-2 - alertDismiss.width;
                text: "";
                color: textColor;
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
                font.pointSize: fontSize;
                font.family: textFont;
                font.weight: Font.Light;
                verticalAlignment: Text.AlignVCenter;
            }

        }

        Text {
            id: alertDismiss;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.right: parent.right;
            topPadding: paddingVertical;
            bottomPadding: paddingVertical;
            rightPadding: paddingHorizontal;
            text: Fa.Icon.times;
            color: Qt.lighter(textColor, 3.0);
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
            font.pointSize: fontSize;
            font.family: iconFont;
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
                    alertDismiss.color = textColor;
                }

                onExited: {
                    alertDismiss.color = Qt.lighter(textColor, 3.0);
                }

            }
        }

    }

}
