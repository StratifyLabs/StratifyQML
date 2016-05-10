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
import "."
import "Fa-4.5.0.js" as Fa

SBaseRectangle {
    id: baseRectangleText;

    property string icon;
    property string text;
    property string dropdown: Fa.Icon.caret_down;
    property alias textObject: baseRectangleTextText;
    property bool hideTextOnSm: true;

    property alias iconObject: rectangleIcon;

    signal clicked();

    //size the rectangle based on the size of the text box
    implicitHeight: font_size + Theme.padding_base_vertical*3;
    implicitWidth: baseRectangleTextText.width;

    onStyleChanged: {
        var items = style.split(" ");
        for(var i=0; i < items.length; i++){
            if( items[i] === "text-left" ){
                baseRectangleTextText.anchors.centerIn = undefined;
                baseRectangleTextText.anchors.left = baseRectangleTextText.parent.left;
            } else if( items[i] === "text-right" ){
                baseRectangleTextText.horizontalAlignment = Text.AlightRight;
            } else if( items[i] === "text-center" ){
                baseRectangleTextText.horizontalAlignment = Text.AlignHCenter;
            } else if( items[i] === "bold" ){
                baseRectangleTextText.font.weight = Font.Bold;
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
            }
        }
    }


    contents.data: [

        Row {
            id: baseRectangleTextText;
            anchors.centerIn: parent;

            leftPadding: padding_horizontal;
            rightPadding: padding_horizontal;
            bottomPadding: padding_vertical;
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
                text: baseRectangleText.text;
                font.pointSize: font_size;
                font.family: Theme.openSansLight.name;
                font.weight: Font.Light;
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignVCenter;
                visible: (icon !== "") && (hideTextOnSm) ? !sm : true;
            }

            Text {
                id: dropDownIcon;
                color: text_color;
                text: baseRectangleText.dropdown;
                font.pointSize: font_size;
                font.family: Theme.fontawesome.name;
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignVCenter;
                height: rectangleText.height;
            }
        },

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

            onClicked: baseRectangleText.clicked();
        }
    ]
}
