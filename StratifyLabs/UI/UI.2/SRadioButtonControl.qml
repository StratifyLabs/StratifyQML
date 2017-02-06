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

import QtQuick 2.5
import StratifyLabs.UI 2.0

SItem {
    visible: false;
    property var target: parent;
    property var active;
    onActiveChanged: {
        //uncheck all but the current value
        var i;
        for(i=0; i < target.children.length; i++){
            if ( target.children[i].type === "radiobutton" ){
                if( active !== target.children[i] ){
                    target.children[i].checked = false;
                }
            }
        }
    }


}
