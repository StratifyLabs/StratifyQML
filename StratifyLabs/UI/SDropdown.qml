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

    signal clicked();
    signal itemClicked();

    blockWidth: true;


    //size the rectangle based on the size of the text box
    implicitHeight: font_size + Theme.padding_base_vertical*3;
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
                bg_color = Theme.btn_primary_bg;
                text_color = Theme.btn_primary_color;
                border_color = Theme.btn_primary_border;
            } else if( items[i] === "default" || (items[i] === "btn-default") ){
                bg_color = Theme.btn_default_bg;
                text_color = Theme.btn_default_color;
                border_color = Theme.btn_default_border;
            } else if( items[i] === "danger" || (items[i] === "btn-danger") ){
                bg_color = Theme.btn_danger_bg;
                text_color = Theme.btn_danger_color;
                border_color = Theme.btn_danger_border;
            } else if( items[i] === "success" || (items[i] === "btn-success") ){
                bg_color = Theme.btn_success_bg;
                text_color = Theme.btn_success_color;
                border_color = Theme.btn_success_border;
            } else if( items[i] === "info" || (items[i] === "btn-info") ){
                bg_color = Theme.btn_info_bg;
                text_color = Theme.btn_info_color;
                border_color = Theme.btn_info_border;
            } else if( items[i] === "warning" || (items[i] === "btn-warning") ){
                bg_color = Theme.btn_warning_bg;
                text_color = Theme.btn_warning_color;
                border_color = Theme.btn_warning_border;
            } else if( items[i] === "close" || (items[i] === "btn-close")){
                bg_color = "transparent";
                text_color = Theme.text_muted;
                border_color = "transparent";
            } else if( items[i] === "block" ){
                blockWidth = true;
            }
        }

        for(i=0; i < items.length; i++){
            if( items[i] === "left" ){
                dropdown = Fa.Icon.caret_left;
                menu.x = Qt.binding(function(){ return mapToItem(menu.parent, 0, 0).x - width - padding_horizontal});
                menu.y = Qt.binding(function(){ return mapToItem(menu.parent, 0, 0).y + height/2 - height/2});
            } else if( items[i] === "right" ){
                dropdown = Fa.Icon.caret_right;
                menu.x = Qt.binding(function(){ return mapToItem(menu.parent, 0, 0).x + width + padding_horizontal});
                menu.y = Qt.binding(function(){ return mapToItem(menu.parent, 0, 0).y + height/2 - height/2});
            } else if( items[i] === "top" ){
                dropdown = Fa.Icon.caret_up;
                menu.x = Qt.binding(function(){ return mapToItem(menu.parent, 0, 0).x + width/2 - width/2});
                menu.y = Qt.binding(function(){ return mapToItem(menu.parent, 0, 0).y - menu.height - padding_vertical});
            } else if( items[i] === "bottom" ){
                dropdown = Fa.Icon.caret_down;
                menu.x = Qt.binding(function(){ return menu.parent.mapFromItem(menu.target, 0, 0).x });
                menu.y = Qt.binding(function(){ return menu.parent.mapFromItem(menu.target, 0, 0).y + height + padding_vertical });
                console.log(menu.parent.mapFromItem(menu.target, 0, 0).x + "," + menu.parent.mapFromItem(menu.target, 0, 0).y);
            }
        }
    }

    Component.onCompleted: styleChanged();
    onHeightChanged: styleChanged();
    onWidthChanged: styleChanged();


    RowLayout {
        id: baseRectangleDropdownText;
        width: parent.width;
        spacing: Theme.padding_base_horizontal;

        Row {
            Layout.fillWidth: true;
            leftPadding: padding_horizontal;
            topPadding: padding_vertical;
            spacing: Theme.padding_base_horizontal/4;
            Text {
                id: rectangleIcon;
                color: text_color;
                text: icon;
                font.pointSize: font_size*1.15;
                font.family: Theme.fontawesome.name;
                font.weight: Font.Light;
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignVCenter;
                height: rectangleText.height;
            }

            Text {
                id: rectangleText;
                color: text_color;
                text: baseRectangleDropdown.text;
                font.pointSize: font_size;
                font.family: Theme.opensans.name;
                font.weight: Font.Light;
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignVCenter;
                visible: (icon !== "") && (hideTextOnSm) ? !sm : true;
            }
        }

        Text {
            topPadding: padding_vertical;
            rightPadding: padding_horizontal;
            id: dropDownIcon;
            color: text_color;
            text: baseRectangleDropdown.dropdown;
            font.pointSize: font_size;
            font.family: Theme.fontawesome.name;
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
            height: rectangleText.height;
        }
    }

    MouseArea {
        anchors.fill: parent;
        hoverEnabled: true;
        onEntered: {
            bg_color = Qt.darker(bg_color, 1.1);
            startHover();
        }

        onExited: {
            bg_color = Qt.lighter(bg_color, 1.1);
            stopHover();
        }

        onClicked: {
            menu.visible = true;
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
            console.log(parent.mapFromItem(target, 0, 0).x + ", " + parent.mapFromItem(target, 0, 0).y);
        }

        //x: parent.mapFromItem(target, 0, 0).x;
        //y: parent.mapFromItem(target, 0, 0).y;
    }
}
