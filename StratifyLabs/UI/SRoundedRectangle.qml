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
import "Fa-4.5.0.js" as Fa
import "."


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

            // Radius should never exceed half of the width or half of the height
            var realTopLeftRadius = Math.min(Math.min(0.5*width, 0.5*height), topLeftRadius);
            var realTopRightRadius = Math.min(Math.min(0.5*width, 0.5*height), topRightRadius);
            var realBottomLeftRadius = Math.min(Math.min(0.5*width, 0.5*height), bottomLeftRadius);
            var realBottomRightRadius = Math.min(Math.min(0.5*width, 0.5*height), bottomRightRadius);

            ctx.save();


            ctx.clearRect(0,0,width,height);
            ctx.lineWidth = borderWidth;

            // Taking into an account pen width
            var realWidth = width-2*ctx.lineWidth;
            var realHeight = height-2*ctx.lineWidth;

            ctx.strokeStyle = borderColor;
            ctx.fillStyle = color;
            ctx.globalAlpha = opacity;
            ctx.lineJoin = "miter";

            ctx.arc(ctx.lineWidth + realTopLeftRadius, ctx.lineWidth +realTopLeftRadius, realTopLeftRadius, Math.PI, Math.PI + Math.PI/2, false);
            ctx.arc(ctx.lineWidth +realWidth-realTopRightRadius, ctx.lineWidth +realTopRightRadius, realTopRightRadius, -Math.PI/2, 0, false);
            ctx.arc(ctx.lineWidth +realWidth-realBottomRightRadius, ctx.lineWidth +realHeight-realBottomRightRadius,realBottomRightRadius, 0, Math.PI/2, false);
            ctx.arc(ctx.lineWidth +realBottomLeftRadius, ctx.lineWidth +realHeight-realBottomLeftRadius, realBottomLeftRadius, Math.PI/2, Math.PI,
             false);
            ctx.closePath();
            ctx.fill();
            ctx.stroke();

            ctx.restore();
        }

    }

}


