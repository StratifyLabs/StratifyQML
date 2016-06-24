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

SItem {
    id: row;
    type: "row";
    default property alias data: contents.data;
    sm: width < theme.screen_sm;


    onSmChanged: {
        for(var i = 0; i < contents.children.length; i++){
            if( contents.children[i].type !== undefined ){
                contents.children[i].sm = sm;
            }
        }
    }

    onVisibleChanged: contents.adjustWidth();

    width: parent.width;
    implicitHeight: fillHeight ? parent.height : contents.childrenRect.height;

    GridLayout {
        rowSpacing: paddingHorizontal;
        rows: 1;
        id: contents;
        height: fillHeight ? parent.height : undefined;
        width: parent.width;

        function alignChildren(){
            for(var i = 0; i < children.length; i++){
                if( children[i].alignment !== undefined ){
                    children[i].Layout.alignment = children[i].alignment;
                }
            }
        }

        function adjustWidth(){
            for(var i = 0; i < children.length; i++){
                var w;
                if( children[i].span !== undefined ){
                    if( children[i].span > 0 ){
                        w = (width - (children.length-1)*rowSpacing) * children[i].span / theme.grid_columns;
                        children[i].Layout.preferredWidth = w;
                    }
                }
            }
        }

        onWidthChanged: {
            adjustWidth();
        }


        Component.onCompleted: {
            alignChildren();
            adjustWidth();
        }
    }

}

