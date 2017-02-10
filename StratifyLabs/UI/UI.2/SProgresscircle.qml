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
import QtQuick.Window 2.2
import StratifyLabs.UI 2.0

Item {
    id: root;

    property alias style: properties.style;
    property alias span: properties.span;
    property alias properties: properties;

    property real value: 0.1;
    property real pixelRatio: Screen.devicePixelRatio;
    //property alias iconVisible: icon.visible;
    //property alias textVisible: text.visible;

    SProperties {
        id: properties;
        backgroundColor: StratifyUI.gray_lighter;
        borderColor: StratifyUI.progress_bar_bg;
        borderRadius: StratifyUI.progress_border_radius;
        borderWidth: StratifyUI.progress_border_width*20;
    }

    implicitWidth: properties.fontContainerHeight*4;
    implicitHeight: properties.fontContainerHeight*4;

    onValueChanged: canvas.requestPaint();

    Canvas {
        id: canvas;
        //double the height and scale down for retina displays
        width: parent.width*pixelRatio;
        height: parent.height*pixelRatio;
        transform: Scale { xScale: 1.0/pixelRatio; yScale: 1.0/pixelRatio; }

        onPaint: {
            var ctx = getContext("2d");
            var x = width / 2;
            var y = height / 2;
            var prog = root.value;
            if( prog < 0.0 ){
                prog = 0.0;
            }

            if( prog > 1.0 ){
                prog = 1.0;
            }

            ctx.clearRect(0, 0, width+1, height+1);

            ctx.beginPath();
            ctx.fillStyle = properties.backgroundColor;
            ctx.moveTo(x, y);
            ctx.arc(x, y, width/2-properties.borderWidth*pixelRatio/5, 0, Math.PI*2, false);
            ctx.closePath();
            ctx.fill();

            ctx.beginPath();
            ctx.fillStyle = properties.borderColor;
            ctx.moveTo(x, y);
            ctx.arc(x, y, width/2, Math.PI*3/2, Math.PI*3/2 + prog*Math.PI*2, false);
            //ctx.arc(x, y, width/2, Math.PI*3/2, Math.PI*3/2 + Math.PI*2, false);
            ctx.closePath();
            ctx.fill();

            ctx.beginPath();
            ctx.fillStyle = "#fff";
            ctx.moveTo(x, y);
            ctx.arc(x, y, width/2 - properties.borderWidth*pixelRatio, 0, Math.PI*2, false);
            ctx.closePath();
            ctx.fill();
        }
    }
}
