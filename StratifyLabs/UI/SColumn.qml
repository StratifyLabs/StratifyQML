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
    id: column;
    default property alias data: contents.data;
    property alias contents: contents;
    type: "column";

    width: parent.width;
    implicitHeight: fillHeight ? parent.height: contents.childrenRect.height;

    GridLayout {
        id: contents;
        columns: 1;
        width: parent.width;
        height: fillHeight ? parent.height : undefined;
        columnSpacing: padding_vertical;

        function alignChildren(){
            for(var i = 0; i < children.length; i++){
                if( children[i].alignment !== undefined ){
                    children[i].Layout.alignment = children[i].alignment;
                }

                if( children[i].fillHeight === true ){
                    children[i].Layout.fillHeight = true;
                }
            }
        }

        Component.onCompleted: {
            alignChildren();
        }

        onWidthChanged:  {
            console.log("Column layout width: " + width);
            for(var i = 0; i < children.length; i++){
                children[i].Layout.preferredWidth = width;
            }
        }
    }


}

