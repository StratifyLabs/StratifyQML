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
import "SCustomize.js" as Theme

SItem {
    id: row;
    type: "row";
    default property alias data: contents.data;
    skinny: width < Theme.screen_sm;

    implicitWidth: parent.width;
    implicitHeight: contents.childrenRect.height;

    GridLayout {
        rowSpacing: Theme.padding_base_horizontal;
        rows: 1;
        id: contents;
        width: parent.width;

        function alignChildren(){
            for(var i = 0; i < children.length; i++){
                if( children[i].alignment !== undefined ){
                    children[i].Layout.alignment = children[i].alignment;
                }
            }
        }

        onWidthChanged: {
            for(var i = 0; i < children.length; i++){
                var w;
                if( children[i].span !== undefined ){
                    if( children[i].span > 0 ){
                        w = (width - (children.length-1)*rowSpacing) * children[i].span / Theme.grid_columns;
                        if( w > children[i].implicitWidth ){
                            children[i].Layout.preferredWidth = w;
                        }
                        if( children[i].type === "column" ){
                            children[i].resize(w);
                        }
                    }
                }
            }
        }

        Component.onCompleted: {
            alignChildren();
        }
    }

}

