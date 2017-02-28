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
import StratifyLabs.UI 2.0

Item {
    id: root;

    property alias style: attr.style;
    property alias span: attr.span;
    property alias attr: attr;

    property bool busy: false;

    property string screen;
    property var current;

    property var animation: SAnimationFade {
        parent: root;
    }

    onAnimationChanged: {
        animation.parent = root;
    }

    SAttributes {
        id: attr;
        type: "animationcontainer";
        fillWidth: true;
    }

    function next(){
        var i = resourceIndex(current);
        i++;
        if( i < resources.length ){
            return resources[i].name;
        }
        return screen;
    }

    function previous(){
        var i = resourceIndex(current);
        i--;
        if( i >= 0 ){
            return resources[i].name;
        }
        return screen;
    }

    onScreenChanged: {
        var target = resource(screen);

        if( root.busy === true ){
            //can't changed the screen while an animation is in progress
            root.screen = current.name;
            return;
        }

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

    Connections {
        target: animation;
        onStarted: {
            root.busy = true;
        }

        onStopped: {
            root.busy = false;
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
