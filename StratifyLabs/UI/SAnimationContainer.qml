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

Item {
    id: root;

    property alias style: properties.style;
    property alias span: properties.span;
    property alias properties: properties;

    property string screen;
    property var current;

    SProperties {
        id: properties;
        type: "animationcontainer";
    }

    onScreenChanged: {
        var target = resource(screen);

        if( current !== undefined ){

            if( resourceIndex(current) < resourceIndex(target) ){
                animation.dir = -1;
            } else {
                animation.dir = 1;
            }

            animation.start(current, target, root);
            current = target;
        } else {
            current = target;
            showScreen(current);
        }
    }

    function showScreen(screen){
        screen.parent = root;
        screen.visible = true;
    }

    function resource(name){
        for(var i = 0; i < resources.length; i++){
            if( name === resources[i].name ){
                return resources[i];
            }
        }
        return 0;
    }

    function resourceIndex(id){
        for(var i = 0; i < resources.length; i++){
            if( resources[i] === id ){
                return i;
            }
        }
        return 0;
    }

}
