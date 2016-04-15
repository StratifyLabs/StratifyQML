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
    id: column;
    default property alias data: contents.data;
    property alias contents: contents;
    type: "column";

    implicitWidth: parent.width;
    implicitHeight: contents.childrenRect.height;

    function resize(w){
        contents.width = w;
    }

    function alignChildren(){
        for(var i = 0; i < children.length; i++){
            if( children[i].alignment !== undefined ){
                children[i].Layout.alignment = children[i].alignment;
            }
        }
    }

    ColumnLayout {
        id: contents;
        width: parent.width;
        spacing: Theme.padding_base_vertical;

        Component.onCompleted: {
            alignChildren();
        }
    }


}

