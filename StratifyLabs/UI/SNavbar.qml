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


Row {

    property var item: SItem {
        type: "navbar";
    }

    property var back; //navigation back in skinny mode
    property var details;

    spacing: Theme.padding_base_horizontal;
    anchors.horizontalCenter: parent.horizontalCenter;

    onWidthChanged: {
        //update item.skinny if width is below threshold
    }

    //when navbar is wide show buttons (and text if it fits)
    //when navbar is skinny (like on touchscreen) -- just show back button and last screen

}
