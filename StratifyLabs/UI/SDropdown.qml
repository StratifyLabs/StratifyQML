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
import QtQuick.Layouts 1.3
import "."
import "Fa-4.5.0.js" as Fa

SBaseRectangle {
    id: baseRectangleDropdown;
    type: "dropdown";

    property alias menuParent: menu.parent;
    property alias model: menu.model;
    property string icon;
    property string text;
    property string dropdown: Fa.Icon.caret_down;
    property alias textObject: baseRectangleDropdownText;
    property bool hideTextOnSm: true;
    property alias iconObject: rectangleIcon;
    property alias activeText: menu.activeText;
    property bool hideMenuCountZero: true;

    signal clicked();
    signal itemClicked();

    blockWidth: true;

    //size the rectangle based on the size of the text box
    implicitHeight: fontSize + paddingVertical*3;
    implicitWidth: (blockWidth == true) ? parent.width : baseRectangleDropdownText.width;

    onStyleChanged: {
        updateStyle();
    }
    function updateStyle(){
        var items = style.split(" ");
        for(var i=0; i < items.length; i++){
            if( items[i] === "text-left" ){
                baseRectangleDropdownText.anchors.centerIn = undefined;
                baseRectangleDropdownText.anchors.left = baseRectangleDropdownText.parent.left;
            } else if( items[i] === "text-right" ){
                baseRectangleDropdownText.horizontalAlignment = Text.AlightRight;
            } else if( items[i] === "text-center" ){
                baseRectangleDropdownText.horizontalAlignment = Text.AlignHCenter;
            } else if( items[i] === "bold" ){
                baseRectangleDropdownText.font.weight = Font.Bold;
            } else if( (items[i] === "primary") || (items[i] === "btn-primary") ){
                backgroundColor = theme.btn_primary_bg;
                textColor = theme.btn_primary_color;
                borderColor = theme.btn_primary_border;
            } else if( items[i] === "default" || (items[i] === "btn-default") ){
                backgroundColor = theme.btn_default_bg;
                textColor = theme.btn_default_color;
                borderColor = theme.btn_default_border;
            } else if( items[i] === "danger" || (items[i] === "btn-danger") ){
                backgroundColor = theme.btn_danger_bg;
                textColor = theme.btn_danger_color;
                borderColor = theme.btn_danger_border;
            } else if( items[i] === "success" || (items[i] === "btn-success") ){
                backgroundColor = theme.btn_success_bg;
                textColor = theme.btn_success_color;
                borderColor = theme.btn_success_border;
            } else if( items[i] === "info" || (items[i] === "btn-info") ){
                backgroundColor = theme.btn_info_bg;
                textColor = theme.btn_info_color;
                borderColor = theme.btn_info_border;
            } else if( items[i] === "warning" || (items[i] === "btn-warning") ){
                backgroundColor = theme.btn_warning_bg;
                textColor = theme.btn_warning_color;
                borderColor = theme.btn_warning_border;
            } else if( items[i] === "close" || (items[i] === "btn-close")){
                backgroundColor = "transparent";
                textColor = theme.text_muted;
                borderColor = "transparent";
            } else if( items[i] === "block" ){
                blockWidth = true;
            }
        }


    }

    function updatePosition(){
        var items = style.split(" ");
        var i;
        for(i=0; i < items.length; i++){
            if( items[i] === "left" ){
                dropdown = Fa.Icon.caret_left;
                menu.x = Qt.binding(function(){ return mapToItem(menu.parent, 0, 0).x - width - paddingHorizontal});
                menu.y = Qt.binding(function(){ return mapToItem(menu.parent, 0, 0).y + height/2 - height/2});
            } else if( items[i] === "right" ){
                dropdown = Fa.Icon.caret_right;
                menu.x = Qt.binding(function(){ return mapToItem(menu.parent, 0, 0).x + width + paddingHorizontal});
                menu.y = Qt.binding(function(){ return mapToItem(menu.parent, 0, 0).y + height/2 - height/2});
            } else if( items[i] === "top" ){
                dropdown = Fa.Icon.caret_up;
                menu.x = Qt.binding(function(){ return mapToItem(menu.parent, 0, 0).x + width/2 - width/2});
                menu.y = Qt.binding(function(){ return mapToItem(menu.parent, 0, 0).y - menu.height - paddingVertical});
            } else if( items[i] === "bottom" ){
                dropdown = Fa.Icon.caret_down;
                menu.x = Qt.binding(function(){ return menu.parent.mapFromItem(menu.target, 0, 0).x });
                menu.y = Qt.binding(function(){ return menu.parent.mapFromItem(menu.target, 0, 0).y + height + paddingVertical });
            }
        }
    }

    Component.onCompleted: styleChanged();
    onVisibleChanged: if( visible ) updatePosition();
    onHeightChanged: updatePosition();
    onWidthChanged: updatePosition();


    RowLayout {
        id: baseRectangleDropdownText;
        width: parent.width;
        spacing: theme.padding_base_horizontal;

        clip: true;

        Row {
            Layout.fillWidth: true;
            leftPadding: paddingHorizontal;
            topPadding: paddingVertical;
            spacing: theme.padding_base_horizontal/4;
            Text {
                id: rectangleIcon;
                color: textColor;
                text: icon;
                font.pointSize: fontSize*1.15;
                font.family: iconFont;
                font.weight: Font.Light;
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignVCenter;
                height: rectangleText.height;
            }

            Text {
                id: rectangleText;
                color: textColor;
                text: baseRectangleDropdown.text;
                font.pointSize: fontSize;
                font.family: textFont;
                font.weight: Font.Light;
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignVCenter;
                visible: (icon !== "") && (hideTextOnSm) ? !sm : true;
            }
        }

        Text {
            topPadding: paddingVertical;
            rightPadding: paddingHorizontal;
            id: dropDownIcon;
            color: textColor;
            text: baseRectangleDropdown.dropdown;
            font.pointSize: fontSize;
            font.family: iconFont;
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
            height: rectangleText.height;
        }
    }


    MouseArea {
        anchors.fill: parent;
        hoverEnabled: true;
        onEntered: {
            backgroundColor = Qt.darker(backgroundColor, 1.1);
            startHover();
        }

        onExited: {
            backgroundColor = Qt.lighter(backgroundColor, 1.1);
            stopHover();
        }

        onClicked: {
            if( menu.visible == false ){
                if( (menu.model.count !== 0) || !hideMenuCountZero ){
                    menu.visible = true;
                }
            } else {
                menu.visible = false;
            }

            style = style;
            baseRectangleDropdown.clicked();
        }
    }

    SDropdownMenu {
        id: menu;
        target: baseRectangleDropdown;
        visible: false;
        width: target.width;

        onClicked: {
            itemClicked();
        }

    }
}
