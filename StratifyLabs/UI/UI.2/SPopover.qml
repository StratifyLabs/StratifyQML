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
import StratifyLabs.UI 2.0

SItem {

    id: base;
    property alias title: textTitle.text;
    property alias content: textContent.text;
    property real pixelRatio: Screen.devicePixelRatio;

    // TODO: to add Dismissive popover functionality
    property string trigger: ""

    type: "popover";
    visible: false;
    opacity: 0
    z: parent.z + 1

    property string currentStyle;

    implicitWidth: Math.max(textTitle.width, textContent.width) + 2*theme.popover_arrow_width;
    implicitHeight: rectanglTitle.height + rectangleContent.height + 2*theme.popover_arrow_width;

    property string position: "left";

    fontSize: theme.font_size_small;
    paddingVertical: theme.padding_small_vertical;
    paddingHorizontal: theme.padding_small_horizontal;

    property bool popoverVisible: false
    onPopoverVisibleChanged: {
        if( currentStyle != style ){
            updateStyle();
            currentStyle = style;
            canvas.requestPaint();
        }
    }
    states: [
        State { when: popoverVisible;
            PropertyChanges {
                target: base;
                opacity: 1.0;
                visible: true
            }
        },
        State { when: !popoverVisible;
            PropertyChanges {
                target: base;
                opacity: 0.0;
                visible: false;
            }
        }
    ]

    transitions: Transition {
        NumberAnimation { property: "opacity"; duration: 250 }
    }

    function updateStyle(){
        var items = parseStyle();
        var i;
        var parentContentItem;
        if ("contents" in parent) {
            parentContentItem = parent.contents;
        } else {
            parentContentItem = parent;
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

    Canvas {
        id: canvas;
        antialiasing: true;
        //double the height and scale down for retina displays
        width: (parent.width)*pixelRatio;
        height: parent.height*pixelRatio;
        transform: Scale { xScale: 1.0/pixelRatio; yScale: 1.0/pixelRatio; }

        onPaint: {
            var ctx = getContext("2d");
            var twidth;
            var theight;

            ctx.save();
            ctx.clearRect(0,0,width,height);
            ctx.lineWidth = 3;
            ctx.strokeStyle = theme.popover_bg;
            ctx.fillStyle = ctx.strokeStyle;
            ctx.globalAlpha = theme.popover_opacity;
            ctx.lineJoin = "round";

            ctx.beginPath();

            if( (position === "left") || (position === "right") ){
                twidth = theme.popover_arrow_width*2;
                theight = theme.popover_arrow_width*4;
            } else {
                twidth = theme.popover_arrow_width*4;
                theight = theme.popover_arrow_width*2;
            }

            if( position === "left" ){
                // draw the triangle on the right
                ctx.translate(width-twidth-1, height/2);
                ctx.moveTo(0,-theight/2);
                ctx.lineTo(twidth, 0);
                ctx.lineTo(0,theight/2);
            } else if( position === "right" ){
                // draw the triangle on the left
                ctx.moveTo(0,height/2);
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

    SRoundedRectangle {
        id: rectanglTitle;
        x: theme.popover_arrow_width;
        y: theme.popover_arrow_width;
        color: theme.popover_title_bg;
        width: parent.width - 2*theme.popover_arrow_width;
        height: textTitle.height;
        radius: theme.btn_border_radius_small;
        borderColor: theme.panel_default_border;

        implicitWidth: textTitle.width;
        implicitHeight: textTitle.height;

        Text {
            id: textTitle;
            topPadding: theme.padding_base_vertical;
            bottomPadding: theme.padding_base_vertical;
            leftPadding: theme.padding_base_horizontal;
            rightPadding: theme.padding_base_horizontal;
            color: theme.text_color;
            font.pointSize:  theme.font_size_base;
            font.family: textFont;
            font.weight: Font.Light;
            width: implicitWidth > theme.popover_max_width ? theme.popover_max_width : implicitWidth;
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
        }
    }

    SRoundedRectangle {
        id: rectangleContent;
        x: theme.popover_arrow_width;
        y: theme.popover_arrow_width + rectanglTitle.height;
        color: theme.popover_bg;
        width: parent.width- 2*theme.popover_arrow_width;
        height: textContent.height;
        radius: theme.btn_border_radius_small;
        borderColor: theme.panel_default_border;

        implicitWidth: textContent.width;
        implicitHeight: textContent.height;

        Text {
            id: textContent;
            topPadding: paddingVertical;
            bottomPadding: paddingVertical;
            leftPadding: paddingHorizontal;
            rightPadding: paddingHorizontal;
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
            color: textColor;
            font.pointSize: fontSize;
            font.family: textFont;
            font.weight: Font.Light;
            width: implicitWidth > theme.popover_max_width ? theme.popover_max_width : implicitWidth;
        }
    }


}
