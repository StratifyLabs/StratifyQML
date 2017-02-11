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

    property alias attr: attr;
    property alias style: attr.style;
    property alias span: attr.span;
    property bool dismissible: true;
    property bool dismissed: false;
    property alias text: text.text;

    //implicitWidth: attr.blockWidth ? (parent ? parent.width : 0) : 0; //if not block width, width must be specified
    implicitHeight: text.height;

    color: attr.backgroundColor;
    border.color:  attr.borderColor;
    border.width: attr.borderWidth;
    radius: attr.borderRadius;

    Text {
        id: text;
        rightPadding: attr.paddingHorizontal;
        leftPadding: attr.paddingHorizontal;
        topPadding: attr.paddingVertical;
        bottomPadding: attr.paddingVertical;
        width: parent.width;
        color: attr.fontColor;
        font.family: attr.fontText;
        font.pixelSize: attr.fontSize;
        font.weight: attr.fontWeight;
        wrapMode: Text.Wrap;
        horizontalAlignment: attr.fontHorizontalAlignment;
        verticalAlignment: attr.fontVerticalAlignment;
    }

    SAttributes {
        id: attr;
        borderRadius: STheme.alert_border_radius;
        borderWidth: STheme.alert_border_width;
        borderColor: STheme.alert_info_border;
        backgroundColor: STheme.alert_info_bg;
        fontColor: STheme.alert_info_text;
        blockWidth: true;

        fontVerticalAlignment: Text.AlignTop;
        fontHorizontalAlignment: Text.AlignLeft;

        onStyleChanged: {
            var items = parseStyle();
            for(var i = 0; i < items.length; i++){
                if( items[i] === "alert-danger" ){
                    backgroundColor = Qt.binding( function(){ return STheme.alert_danger_bg; });
                    textColor = Qt.binding( function(){ return STheme.alert_danger_text; });
                    borderColor = Qt.binding( function(){ return STheme.alert_danger_border; });
                } else if( items[i] === "alert-success" ){
                    backgroundColor = Qt.binding( function(){ return STheme.alert_success_bg; });
                    textColor = Qt.binding( function(){ return STheme.alert_success_text; });
                    borderColor = Qt.binding( function(){ return STheme.alert_success_border; });
                } else if( items[i] === "alert-info" ){
                    backgroundColor = Qt.binding( function(){ return STheme.alert_info_bg; });
                    textColor = Qt.binding( function(){ return STheme.alert_info_text; });
                    borderColor = Qt.binding( function(){ return STheme.alert_info_border; });
                } else if( items[i] === "alert-warning" ){
                    backgroundColor = Qt.binding( function(){ return STheme.alert_warning_bg; });
                    textColor = Qt.binding( function(){ return STheme.alert_warning_text; });
                    borderColor = Qt.binding( function(){ return STheme.alert_warning_border; });
                }
            }
        }
    }

    Text {
        id: alertDismiss;
        anchors.top: control.top;
        anchors.right: control.right;
        topPadding: attr.paddingVertical;
        rightPadding: attr.paddingHorizontal;
        text: Fa.Icon.times;
        color: Qt.lighter(attr.textColor, 3.0);
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
        font.pointSize: attr.fontSize;
        font.family: attr.fontIcon;
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
                alertDismiss.color = attr.textColor;
            }

            onExited: {
                alertDismiss.color = Qt.lighter(attr.textColor, 3.0);
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
