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
    id: root;
    type: "animation";

    property alias inTarget: inAnimation.target;
    property alias outTarget: outAnimation.target;
    property real duration: 250;
    property real dir: 1;

    property var targetParent: parent;

    signal stopped();


    function start(current, target, parent){
        inAnimation.target = target;
        outAnimation.target = current;
        targetParent = parent;

        target.parent = parent;
        target.visible = true;

        inAnimation.start();
        outAnimation.start();
    }

    PropertyAnimation {
        id: outAnimation;
        duration: root.duration;
        easing.type: Easing.InQuad;
        properties: "opacity";
        from: 1.0;
        to: 0.0;

        onStopped: {
            target.visible = false;
            root.stopped();
        }
    }

    PropertyAnimation {
        id: inAnimation;
        duration: root.duration;
        easing.type: Easing.InQuad;
        properties: "opacity";
        from: 0.0;
        to: 1.0;
        onStopped: {
            root.stopped();
        }
    }
}
