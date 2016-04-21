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
import "SCustomize.js" as Theme
import "Fa-4.5.0.js" as Fa


Item {
    property real pixelRatio: Screen.devicePixelRatio;
    property real radius: 0.1;
    property real topRadius: radius/2;
    property real bottomRadius: radius/2;
    property real leftRadius: radius/2;
    property real rightRadius: radius/2;
    property real topLeftRadius: (topRadius + leftRadius)*pixelRatio;
    property real topRightRadius: (topRadius + rightRadius)*pixelRatio;
    property real bottomLeftRadius: (bottomRadius + leftRadius)*pixelRatio;
    property real bottomRightRadius: (bottomRadius + rightRadius)*pixelRatio;
    property real borderWidth: 1;
    property string borderColor: "#000";
    property string color: "#000";

    onBorderColorChanged: canvas.requestPaint();
    onColorChanged: canvas.requestPaint();

    Canvas {
        id: canvas;
        antialiasing: true;
        //double the height and scale down for retina displays
        width: (parent.width)*pixelRatio;
        height: (parent.height)*pixelRatio;
        transform: Scale { xScale: 1.0/pixelRatio; yScale: 1.0/pixelRatio; }
        onPaint: {
            var ctx = getContext("2d");
            ctx.save();

            ctx.clearRect(0,0,width,height);
            ctx.lineWidth = borderWidth*2;
            ctx.strokeStyle = borderColor;
            ctx.fillStyle = color;
            ctx.globalAlpha = opacity;
            ctx.lineJoin = "miter";

            ctx.beginPath();
            ctx.arc(topLeftRadius, topLeftRadius, topLeftRadius, Math.PI, Math.PI + Math.PI/2, false);
            ctx.arc(width-topRightRadius, topRightRadius, topRightRadius, -Math.PI/2, 0, false);
            ctx.arc(width-bottomRightRadius, height-bottomRightRadius, bottomRightRadius, 0, Math.PI/2, false);
            ctx.arc(bottomLeftRadius, height-bottomLeftRadius, bottomLeftRadius, Math.PI/2, Math.PI,
             false);
            ctx.closePath();
            ctx.fill();
            ctx.stroke();

            ctx.restore();
        }

    }

}


