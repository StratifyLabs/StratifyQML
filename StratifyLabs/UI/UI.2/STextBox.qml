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

Rectangle {
  id: control;
  property alias style: attr.style;
  property alias span: attr.span;
  property alias attr: attr;
  property alias text: textArea.text;
  property alias placeholder: textArea.placeholderText;
  property alias textArea: textArea;
  property alias textBox: control.textArea;
  property alias flickable: flickable;
  property alias verticalScroll: verticalScrollBar;
  property alias horizontalScroll: horizontalScrollBar;

  SAttributes {
    id: attr;
    type: "textbox";
    borderColor: STheme.gray_light;
    fillWidth: true;
    fontHorizontalAlignment: Text.AlignLeft;
    fontVerticalAlignment: Text.AlignTop;

    onStyleChanged: {
      var items = parseStyle();
      for(var i=0; i < items.length; i++){
        if( items[i] === "read-only" ){
          control.textArea.readOnly = true;
        } else if( items[i] === "read-write" ){
          control.textArea.readOnly = false;
        }
      }
    }
  }

  width: parent ? (attr.fillWidth ? parent.width : undefined) : undefined;
  height: parent ? (attr.fillHeight ? parent.height : undefined) : undefined;
  border.width: attr.borderWidth;
  radius: attr.borderRadius;
  border.color: attr.borderColor;
  color: attr.backgroundColor;

  Flickable {
    id: flickable;
    clip: true;
    anchors.fill: parent;
    flickableDirection: Flickable.AutoFlickIfNeeded;


    TextArea.flickable: TextArea {
      id: textArea;
      wrapMode: TextArea.Wrap;
      color: attr.fontColor;
      font.pointSize: attr.fontSize;
      font.family: attr.fontText;
      font.weight: attr.fontWeight;
      horizontalAlignment: attr.fontHorizontalAlignment;
      verticalAlignment: attr.fontVerticalAlignment;
      selectedTextColor: attr.fontColorSelected;
      selectByMouse: true;
      selectByKeyboard: true;
      selectionColor: attr.backgroundColorFontSelection;
    }

    ScrollBar.vertical: ScrollBar {
      id: verticalScrollBar;
    }

    ScrollBar.horizontal: ScrollBar {
      id: horizontalScrollBar;
      visible: false;
    }
  }
}
