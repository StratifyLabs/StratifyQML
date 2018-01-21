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
import StratifyLabs.UI 1.0

SItem {
    id: base;
    property alias text: text.text;
    property real pixelRatio: Screen.devicePixelRatio;
    type: "tooltip";
    visible: true;
    z: Infinity;

    property var target: parent;

    opacity: 0.0;

    property bool tooltipVisible: false;
    onTooltipVisibleChanged: {
        updateStyle();
        if( currentStyle != style ){
            canvas.requestPaint();
        }
        currentStyle = style;
    }

    states: [
        State { when: tooltipVisible;
            PropertyChanges {   target: base; opacity: 1.0    }
        },
        State { when: !tooltipVisible;
            PropertyChanges {   target: base; opacity: 0.0    }
        }
    ]

    transitions: Transition {
        NumberAnimation { property: "opacity"; duration: 250 }
    }

    property string currentStyle;

    implicitWidth: text.width + 2*theme.tooltip_arrow_width;
    implicitHeight: text.height + 2*theme.tooltip_arrow_width;

    property string position: "left";

    fontSize: theme.font_size_small;
    paddingVertical: theme.padding_small_vertical;
    paddingHorizontal: theme.padding_small_horizontal;

    function updateStyle(){
        var items = parseStyle();
        var i;
        var parentContentItem;
        if ("contents" in target) {
            parentContentItem = target.contents;
        } else {
            parentContentItem = target;
        }

        for(i=0; i < items.length; i++){
            if( items[i] === "left" ){
                position = items[i];
                x = parentContentItem.mapToItem(parent, 0, 0).x - width;
                y = parentContentItem.mapToItem(parent, 0, 0).y + parentContentItem.height/2 - height/2;
            } else if( items[i] === "right" ){
                position = items[i];
                x = parentContentItem.mapToItem(parent, 0, 0).x + parentContentItem.width;
                y = parentContentItem.mapToItem(parent, 0, 0).y + parentContentItem.height/2 - height/2;
            } else if( items[i] === "top" ){
                position = items[i];
                x = parentContentItem.mapToItem(parent, 0, 0).x + parentContentItem.width/2 - width/2;
                y = parentContentItem.mapToItem(parent, 0, 0).y - height;
            } else if( items[i] === "bottom" ){
                position = items[i];
                x = parentContentItem.mapToItem(parent, 0, 0).x + parentContentItem.width/2 - width/2;
                y = parentContentItem.mapToItem(parent, 0, 0).y + parentContentItem.height;
            }
        }
    }

    Rectangle {
        id: rectangle;
        x: theme.tooltip_arrow_width;
        y: theme.tooltip_arrow_width;
        color: theme.tooltip_bg;
        width: text.width;
        height: text.height;
        radius: theme.btn_border_radius_small;
        border.color: theme.tooltip_bg;
        z: parent.z;
    }


    Canvas {
        id: canvas;
        antialiasing: true;
        //double the height and scale down for retina displays
        width: (parent.width)*pixelRatio;
        height: parent.height*pixelRatio;
        transform: Scale { xScale: 1.0/pixelRatio; yScale: 1.0/pixelRatio; }
        z: parent.z;

        onPaint: {
            var ctx = getContext("2d");
            var twidth;
            var theight;

            ctx.save();
            ctx.clearRect(0,0,width,height);
            ctx.lineWidth = 3;
            ctx.strokeStyle = theme.tooltip_bg;
            ctx.fillStyle = ctx.strokeStyle;
            ctx.globalAlpha = theme.tooltip_opacity;
            ctx.lineJoin = "round";

            ctx.beginPath();

            if( (position === "left") || (position === "right") ){
                twidth = theme.tooltip_arrow_width*2;
                theight = theme.tooltip_arrow_width*4;
            } else {
                twidth = theme.tooltip_arrow_width*4;
                theight = theme.tooltip_arrow_width*2;
            }

            if( position === "left" ){
                // draw the triangle on the right
                ctx.translate(width-twidth-1, height/2);
                ctx.moveTo(0,-theight/2);
                ctx.lineTo(twidth, 0);
                ctx.lineTo(0,theight/2);
            } else if( position === "right" ){
                // draw the triangle on the left
                ctx.moveTo(1,height/2);
                ctx.lineTo(twidth, height/2-theight/2);
                ctx.lineTo(twidth,height/2+theight/2);
            } else if( position === "top" ){
                // draw the triangle on the bottom
                ctx.translate(width/2, height-theight);
                ctx.moveTo(-twidth/2,0);
                ctx.lineTo(0, theight);
                ctx.lineTo(twidth/2,0);
            } else if( position === "bottom" ){
                // draw the triangle on the top
                ctx.moveTo(width/2, 0);
                ctx.lineTo(width/2-twidth/2, theight);
                ctx.lineTo(width/2+twidth/2, theight);
            }

            ctx.closePath();
            ctx.fill();

            ctx.restore();
        }
    }

    Text {
        id: text;
        x: theme.tooltip_arrow_width;
        y: theme.tooltip_arrow_width;
        topPadding: paddingVertical;
        bottomPadding: paddingVertical;
        leftPadding: paddingHorizontal;
        rightPadding: paddingHorizontal;
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
        color: theme.tooltip_color;
        font.pointSize: fontSize;
        font.family: textFont;
        font.weight: Font.Light;
        width: implicitWidth > theme.tooltip_max_width ? theme.tooltip_max_width : implicitWidth;
        z: parent.z;
    }

}
