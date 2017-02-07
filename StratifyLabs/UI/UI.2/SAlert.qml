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

    property alias properties: properties;
    property alias style: properties.style;
    property alias span: properties.span;
    property bool dismissible: true;
    property bool dismissed: false;
    property alias text: text.text;

    //implicitWidth: properties.blockWidth ? (parent ? parent.width : 0) : 0; //if not block width, width must be specified
    implicitHeight: text.height;

    color: properties.backgroundColor;
    border.color:  properties.borderColor;
    border.width: properties.borderWidth;
    radius: properties.borderRadius;

    Text {
        id: text;
        rightPadding: properties.paddingHorizontal;
        leftPadding: properties.paddingHorizontal;
        topPadding: properties.paddingVertical;
        bottomPadding: properties.paddingVertical;
        width: parent.width;
        color: properties.fontColor;
        font.family: properties.fontText;
        font.pixelSize: properties.fontSize;
        font.weight: properties.fontWeight;
        wrapMode: Text.Wrap;
        horizontalAlignment: properties.fontHorizontalAlignment;
        verticalAlignment: properties.fontVerticalAlignment;
    }

    SProperties {
        id: properties;
        borderRadius: StratifyUI.alert_border_radius;
        borderWidth: StratifyUI.alert_border_width;
        borderColor: StratifyUI.alert_info_border;
        backgroundColor: StratifyUI.alert_info_bg;
        fontColor: StratifyUI.alert_info_text;
        blockWidth: true;

        fontVerticalAlignment: Text.AlignTop;
        fontHorizontalAlignment: Text.AlignLeft;

        onStyleChanged: {
            var items = parseStyle();
            for(var i = 0; i < items.length; i++){
                if( items[i] === "alert-danger" ){
                    backgroundColor = Qt.binding( function(){ return StratifyUI.alert_danger_bg; });
                    textColor = Qt.binding( function(){ return StratifyUI.alert_danger_text; });
                    borderColor = Qt.binding( function(){ return StratifyUI.alert_danger_border; });
                } else if( items[i] === "alert-success" ){
                    backgroundColor = Qt.binding( function(){ return StratifyUI.alert_success_bg; });
                    textColor = Qt.binding( function(){ return StratifyUI.alert_success_text; });
                    borderColor = Qt.binding( function(){ return StratifyUI.alert_success_border; });
                } else if( items[i] === "alert-info" ){
                    backgroundColor = Qt.binding( function(){ return StratifyUI.alert_info_bg; });
                    textColor = Qt.binding( function(){ return StratifyUI.alert_info_text; });
                    borderColor = Qt.binding( function(){ return StratifyUI.alert_info_border; });
                } else if( items[i] === "alert-warning" ){
                    backgroundColor = Qt.binding( function(){ return StratifyUI.alert_warning_bg; });
                    textColor = Qt.binding( function(){ return StratifyUI.alert_warning_text; });
                    borderColor = Qt.binding( function(){ return StratifyUI.alert_warning_border; });
                }
            }
        }
    }

    Text {
        id: alertDismiss;
        anchors.top: control.top;
        anchors.right: control.right;
        topPadding: properties.paddingVertical;
        rightPadding: properties.paddingHorizontal;
        text: Fa.Icon.times;
        color: Qt.lighter(properties.textColor, 3.0);
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
        font.pointSize: properties.fontSize;
        font.family: properties.fontIcon;
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
                alertDismiss.color = properties.textColor;
            }

            onExited: {
                alertDismiss.color = Qt.lighter(properties.textColor, 3.0);
            }

        }
    }



    onOpacityChanged: {
        if( opacity < 0.01 ){
            visible = false;
        } else if ( opacity > 0.01 ){
            visible = true;
        }
    }

    states: [
        State { when: dismissed;
            PropertyChanges {   target: control; opacity: 0.0    }
        },
        State { when: !dismissed;
            PropertyChanges {   target: control; opacity: 1.0    }
        }
    ]

    transitions: Transition {
        NumberAnimation { property: "opacity"; duration: 150 }
    }






}
