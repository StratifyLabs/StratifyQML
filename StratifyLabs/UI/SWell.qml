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

SItem {
    id: base;
    type: "well";

    default property alias data: contents.data;
    property alias text: wellText.text;
    property real padding_vertical: Theme.padding_base_vertical;
    property real padding_horizontal: Theme.padding_base_horizontal;
    property real font_size: Theme.font_size_base;
    implicitWidth: parent.width;
    implicitHeight: wellRectangle.height;

    onStyleChanged: {
        var items = parseStyle();
        var i;
        for(i=0; i < items.length; i++){
            if( items[i] === "well-sm" ){
                padding_vertical = Theme.padding_small_vertical;
                padding_horizontal = Theme.padding_small_horizontal;
            } else if( items[i] === "well-lg" ){
                padding_vertical = Theme.padding_large_vertical;
                padding_horizontal = Theme.padding_large_horizontal;
            } else if( items[i] === "well-default" ){
                padding_vertical = Theme.padding_base_vertical;
                padding_horizontal = Theme.padding_base_horizontal;
            }
        }
    }

    Rectangle {
        id: wellRectangle;

        implicitWidth: parent.width;
        implicitHeight: contents.height;

        color: Theme.well_bg;
        border.color: Theme.well_border;
        border.width: 1;
        radius: Theme.panel_border_radius;

        SContainer {
            id: contents;
            padding_horizontal: base.padding_horizontal;
            padding_vertical: base.padding_vertical;
            Text {
                id: wellText;
                anchors.top: parent.top;
                anchors.horizontalCenter: parent.horizontalCenter;
                width: parent.width-2;
                text: "";
                color: Theme.text_color;
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
                font.pointSize: font_size;
                font.family: openSansLight.name;
                font.weight: Font.Light;
            }
        }

    }

}
