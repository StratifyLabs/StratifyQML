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
import QtQuick.Controls 2.1
import StratifyLabs.UI 2.0

Item {

    id: modal;
    anchors.fill: parent;
    property alias style: attr.style;
    property alias span: attr.span;
    property alias attr: attr;
    property bool modalVisible: false;
    property real duration: 300;
    property string title;
    property real standardButtons: Dialog.Ok | Dialog.Cancel;

    //keep it on top
    z:1;
    default property alias data: dialogContents.data;

    signal accepted();
    signal rejected();
    signal cancelled();

    function accept(){
        modalVisible = false;
        modal.accepted();
    }

    function reject(){
        modalVisible = false;
        modal.rejected();
    }

    function open(){
        modalVisible = true;
    }

    function close(){
        modalVisible = false;
    }

    SAttributes {
        id: attr;
        backgroundColor: STheme.modal_backdrop_bg;
    }

    states: [
        State {
            name: "visible";
            when: modalVisible;
            PropertyChanges { target: background; opacity: STheme.modal_backdrop_opacity; }
            PropertyChanges { target: dialog; opacity: 1.0; }
            PropertyChanges { target: dialog; y: 50; }
        },
        State {
            name: "invisible";
            when: !modalVisible;
            PropertyChanges { target: background; opacity: 0.0; }
            PropertyChanges { target: dialog; opacity: 0.0; }
            PropertyChanges { target: dialog; y: 0; }
        }
    ]


    transitions: [
        Transition {
            from: "visible";
            to: "invisible";
            NumberAnimation { target: background; properties: "opacity"; easing.type: Easing.InOutQuad; duration: modal.duration; }
            NumberAnimation { target: dialog; properties: "y"; easing.type: Easing.Linear; duration: modal.duration;  }
            NumberAnimation { target: dialog; properties: "opacity"; easing.type: Easing.InOutQuad; duration: modal.duration; onStopped: visible = false; }
        },
        Transition {
            from: "invisible";
            to: "visible";
            NumberAnimation { target: background; properties: "opacity"; easing.type: Easing.InOutQuad; duration: modal.duration; }
            NumberAnimation { target: dialog; properties: "opacity"; easing.type: Easing.InOutQuad; duration: modal.duration; }
            NumberAnimation { target: dialog; properties: "y"; easing.type: Easing.Linear; duration: modal.duration; onStarted: visible = true; }
        }
    ]

    Rectangle {
        id: background;
        anchors.fill: parent;
        color: attr.backgroundColor;
        opacity: STheme.modal_backdrop_opacity;
        z:-1;
        MouseArea {
            anchors.fill: parent;
            enabled: modalVisible;
        }
    }



    Rectangle {
        id: dialog;
        //anchors.centerIn: parent;
        anchors.horizontalCenter: parent.horizontalCenter;

        width: STheme.screen_md < modal.width*3/4 ? STheme.screen_md : modal.width*3/4;
        implicitHeight: childrenRect.height;

        color: STheme.body_bg;
        radius: attr.borderRadius;
        border.width: attr.borderWidth;
        border.color: attr.borderColor;

        SColumn {
            SRow {
                visible: modal.title !== "";
                SText {
                    span: 1;
                    style: "left";
                    leftPadding: attr.paddingHorizontal;
                    rightPadding: attr.paddingHorizontal;
                    text: modal.title;
                    wrapMode: Text.Wrap;
                    font.weight: Font.Bold;
                }
                SButton {
                    span: 1;
                    style: "right btn-close";
                    icon: Fa.Icon.times;
                    onClicked: modal.reject();
                }
            }

            SHLine { attr.paddingVertical: 0; visible: modal.title !== ""; }

            SContainer {
                width: undefined;
                //attr.fillWidth: false;
                id: dialogContents;
            }

            SHLine { attr.paddingVertical: 0; visible: modal.standardButtons; }
            SContainer {
                visible: modal.standardButtons;
                SRow {
                    SGroup {
                        style: "right"; span: 12;
                        SButton {
                            style: "block btn-danger";
                            icon: Fa.Icon.times;
                            onClicked: modal.reject();
                            visible: modal.standardButtons & Dialog.Cancel;
                        }
                        SButton {
                            style: "block btn-success";
                            icon: Fa.Icon.check;
                            onClicked: modal.accept();
                            visible: modal.standardButtons & Dialog.Ok;
                        }
                    }
                }
            }
        }
    }
}
