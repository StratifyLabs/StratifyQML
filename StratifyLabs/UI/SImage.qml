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

SItem {

    default property alias data: contents.data;
    property string border_color: Theme.panel_default_border;
    property alias source: image.source;

    implicitWidth: parent.width;
    implicitHeight: contents.height;
    blockWidth: true;

    onStyleChanged: {
        var items = parseStyle();
        var i;
        for(i=0; i < items.length; i++){
            if( items[i] === "img-rounded" ){
                contents.radius = Theme.border_radius_large;
            } else if( items[i] === "img-circle" ){
                contents.radius = Qt.binding(function(){ return contents.width/2 });
            } else if( items[i] === "img-thumbnail" ){

            }
        }
    }


    Rectangle {

        // \todo This doesn't mask the corners off -- may have to use OpacityMask and generate the rounded image
        id: contents;
        radius: 0;
        color: Theme.body_bg;
        border.color: border_color;
        border.width: 1;

        implicitWidth: parent.width;
        implicitHeight: image.height + 2*padding_vertical;
        clip: true;

        Image {
            x: padding_horizontal;
            y: padding_vertical;
            id: image;


        }
    }


}
