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

import QtQuick 2.10
import QtQuick.Controls 2.3
import StratifyLabs.UI 3.0

Item {

  id: modal;
  anchors.fill: parent;
  property alias style: attr.style;
  property alias span: attr.span;
  property alias attr: attr;
  property bool modalVisible: false;
  property real duration: 300;
  property string title;
  property bool closeButtonVisible: true;
  property real standardButtons: Dialog.Ok | Dialog.Cancel;
  property color headerColor: attr.fontColor;
  property color headerBackgroundColor: "transparent";
  property color footerBackgroundColor: "transparent";

  //keep it on top
  z: 100;
  default property alias data: dialogContents.data;

  signal accepted();
  signal rejected();
  signal cancelled();

  enabled: modalVisible;

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
    type: "modal";
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
    z:1;
    MouseArea {
      anchors.fill: parent;
      enabled: modalVisible;
    }
  }



  Rectangle {
    id: dialog;
    //anchors.centerIn: parent;
    anchors.horizontalCenter: parent.horizontalCenter;
    clip: true;
    z: 2;
    width: STheme.screen_md < modal.width*3/4 ? STheme.screen_md : modal.width*3/4;
    implicitHeight: childrenRect.height;

    color: STheme.body_bg;
    radius: attr.borderRadius;
    border.width: attr.borderWidth;
    border.color: attr.borderColor;

    SColumn {
      //attr.paddingVertical: 0;
      SContainer {
        color: modal.headerBackgroundColor;
        SRow {
          visible: modal.title !== "";
          SText {
            span: 1;
            style: "left text-lg";
            topPadding: attr.paddingVertical;
            bottomPadding: attr.paddingVertical;
            leftPadding: attr.paddingHorizontal;
            rightPadding: attr.paddingHorizontal;
            text: modal.title;
            wrapMode: Text.Wrap;
            font.weight: Font.Bold;
            color: modal.headerColor;
          }
          SButton {
            span: 1;
            visible: modal.closeButtonVisible;
            style: "right btn-naked";
            symbol: Fa.Icon.times;
            onClicked: modal.reject();
            enabled: modalVisible;
          }
        }
      }

      SHLine { attr.paddingVertical: 0; visible: modal.title !== "" && modal.headerBackgroundColor === "transparent"; }

      SContainer {
        id: dialogContents;
        width: undefined;
      }

      SHLine {
        attr.paddingVertical: 0;
        visible: modalVisible && modal.standardButtons && modal.footerBackgroundColor === "transparent";
      }
      SContainer {
        visible: modalVisible && modal.standardButtons;
        color: footerBackgroundColor;
        attr.paddingVertical: STheme.padding_large_vertical;
        SRow {
          SGroup {
            style: "right"; span: 12;
            SButton {
              style: "block btn-danger";
              symbol: Fa.Icon.times;
              onClicked: modal.reject();
              visible: modalVisible && (modal.standardButtons & Dialog.Cancel);
              enabled: modalVisible;
            }
            SButton {
              style: "block btn-success";
              symbol: Fa.Icon.check;
              onClicked: {
                modal.accept();
              }
              visible: modalVisible && (modal.standardButtons & Dialog.Ok);
              enabled: modalVisible;
            }
          }
        }
      }
    }
  }
}
