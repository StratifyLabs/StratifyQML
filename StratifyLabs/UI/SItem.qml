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
import QtQuick.Window 2.2
import "."

Item {
    id: self;
    property string name;
    property alias item: self;
    property string style;
    property string type: "item";
    property real span: 0;
    property bool hideOnSm: false;
    property bool sm: false;
    property real alignment: Qt.AlignTop | Qt.AlignLeft;

    property real tooltipDelay: theme.tooltip_delay;
    property real popoverDelay: theme.popover_delay;

    property bool blockWidth: false;
    property bool fillHeight: false;

    property var tooltip: null;
    property var popover: null;

    //This is the naming convention that should be used throughout private items (items not typically exposed to public)
    property bool sItemHovered;

    z: 0;

    //these names are not consistent -- need to user camelcase -- and add a prefix sItemPaddingVertical;
    property real paddingVertical: theme.padding_base_vertical;
    property real paddingHorizontal: theme.padding_base_horizontal;
    property real fontSize: theme.font_size_base;
    property color textColor: theme.text_color;
    property color backgroundColor: "transparent";
    property real radius: theme.btn_border_radius_base;
    property color borderColor: "transparent";

    property string textFont: theme.font_family_base.name;
    property string iconFont: theme.font_family_icon.name;


    visible: hideOnSm && sm ? false : true;

    function parseStyle(){ return style.split(" "); }

    onStyleChanged: {
        var items = parseStyle();
        for(var i=0; i < items.length; i++){
            if( items[i] === "hide-sm" ){
                hideOnSm = true;
            } else if( items[i] === "fill" ){
                fillHeight = true;
            } else if( items[i] === "block" ){
                blockWidth = true;
            } else if( items[i] === "top" ){
                alignment &= ~(Qt.AlignBottom | Qt.AlignCenter);
                alignment |= Qt.AlignTop;
            } else if( items[i] === "bottom" ){
                alignment &= ~(Qt.AlignTop | Qt.AlignCenter);
                alignment |= Qt.AlignBottom;
            } else if( items[i] === "middle" ){
                alignment &= ~(Qt.AlignBottom | Qt.AlignTop);
                alignment |= Qt.AlignCenter;
            } else if( items[i] === "left" ){
                alignment &= ~(Qt.AlignRight | Qt.AlignHCenter);
                alignment |= Qt.AlignLeft;
            } else if( items[i] === "right" ){
                alignment &= ~(Qt.AlignLeft | Qt.AlignHCenter);
                alignment |= Qt.AlignRight;
            } else if( items[i] === "center" ){
                alignment &= ~(Qt.AlignLeft | Qt.AlignRight);
                alignment |= Qt.AlignHCenter;
            } if( items[i] === "h1" ){
                fontSize = theme.font_size_h1;
            } else if( items[i] === "h2" ){
                fontSize = theme.font_size_h2;
            } else if( items[i] === "h3" ){
                fontSize = theme.font_size_h3;
            } else if( items[i] === "h4" ){
                fontSize = theme.font_size_h4;
            } else if( items[i] === "h5" ){
                fontSize = theme.font_size_h5;
            } else if( items[i] === "h6" ){
                fontSize = theme.font_size_h6;
            } else if( items[i] === "lg" ){
                fontSize = theme.font_size_large;
                paddingVertical = theme.padding_large_vertical;
                paddingHorizontal = theme.padding_large_horizontal;
            } else if( items[i] === "sm" ){
                fontSize = theme.font_size_small;
                paddingVertical = theme.padding_small_vertical;
                paddingHorizontal = theme.padding_small_horizontal;
            } else if( items[i] === "xs" ){
                fontSize = theme.font_size_small;
                paddingVertical = theme.padding_xs_vertical;
                paddingHorizontal = theme.padding_xs_horizontal;
            } else if( items[i] === "bold" ){
                textFont = theme.font_family_bold.name;
            }
        }
    }

    Component.onCompleted: {
        var i;
        for(i=0; i < children.length; i++){
            if( children[i].type === "tooltip" ){
                tooltip = children[i];
            } else if(children[i].type === "popover"){
                popover = children[i];
            }
        }
    }

    function startHover(){
        hoverTimer.start();
        sItemHovered = true;
    }

    function stopHover(){
        hoverTimer.stop();
        sItemHovered = false;
        if( tooltip != null ){
            tooltip.tooltipVisible = false;
        }
    }

    Timer {
        id: hoverTimer;
        interval: tooltipDelay;
        repeat: false;
        onTriggered: {
            if( tooltip != null ){
                tooltip.tooltipVisible = true;
            }
        }
    }

    Connections {
        ignoreUnknownSignals: true
        target: self
        onClicked: {
            if(self.popover) {
                popoverTimer.start();
            }
        }

    }

    Timer {
        id: popoverTimer;
        interval: popoverDelay;
        repeat: false;
        onTriggered: {
            if( popover != null ){
                popover.popoverVisible = !popover.popoverVisible;
            }
        }
    }

}
