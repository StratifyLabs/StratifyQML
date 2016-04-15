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
import "SCustomize.js" as Theme

SBaseRectangleText {

    // TODO Badge font size and padding need to be smaller -- need to check bootstrap code

    type: "badge";
    radius: Theme.badge_border_radius;
    bg_color: Theme.badge_bg;
    text_color: Theme.badge_color;
    border_color: Theme.badge_bg;

    onStyleChanged: {
        var items = parseStyle();
        for(var i = 0; i < items.length; i++){
            if( items[i] === "active" ){
                bg_color = Theme.badge_active_bg;
                text_color = Theme.badge_active_color;
                border_color = Theme.badge_active_bg;
            }
        }
    }
}
