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
import QtQuick.Controls 2.1
import QtQuick.Controls.impl 2.1
import StratifyLabs.UI 2.0

ProgressBar {
    id: control;
    //supports success, info, warning, danger, striped, active (animated), stacked

    property alias style: attr.style;
    property alias span: attr.span;
    property alias attr: attr;

    SAttributes {
        id: attr;
        type: "progressbar";
        blockWidth: true;
        backgroundColor: STheme.gray_lighter;
        color: STheme.progress_bar_color;
        borderColor: STheme.progress_bar_bg;
        borderRadius: STheme.progress_border_radius;
        borderWidth: STheme.progress_border_width;
    }

    implicitWidth: 0;
    implicitHeight: attr.fontContainerHeight;

    contentItem: Rectangle {
        id: strip
        x: control.x;
        implicitWidth: 10;
        height: control.height;
        scale: control.mirrored ? -1 : 1
        color: attr.backgroundColor;
        radius: attr.borderRadius;
        border.color: attr.backgroundColor;

        Rectangle {
            color: attr.color;
            width: parent.width * control.value;
            height: parent.height;
            radius: attr.borderRadius;
        }

    }

    background: null;


    onStyleChanged: {
        var items = style.split(" ");
        for(var i = 0; i < items.length; i++){
            if( items[i] === "progress-bar-primary" ){
                attr.color = Qt.binding( function(){ return STheme.progress_bar_bg; });
                attr.borderColor = Qt.binding( function(){ return STheme.progress_bar_bg; });
            } else if( items[i] === "progress-bar-default" ){
                attr.color = Qt.binding( function(){ return STheme.progress_bar_bg; });
                attr.borderColor = Qt.binding( function(){ return STheme.progress_bar_bg; });
            } else if( items[i] === "progress-bar-danger" ){
                attr.color = Qt.binding( function(){ return STheme.progress_bar_danger_bg; });
                attr.borderColor = Qt.binding( function(){ return STheme.progress_bar_danger_bg; });
            } else if( items[i] === "progress-bar-success" ){
                attr.color = Qt.binding( function(){ return STheme.progress_bar_success_bg; });
                attr.borderColor = Qt.binding( function(){ return STheme.progress_bar_success_bg; });
            } else if( items[i] === "progress-bar-info" ){
                attr.color = Qt.binding( function(){ return STheme.progress_bar_info_bg; });
                attr.borderColor = Qt.binding( function(){ return STheme.progress_bar_info_bg; });
            } else if( items[i] === "progress-bar-warning" ){
                attr.color = Qt.binding( function(){ return STheme.progress_bar_warning_bg; });
                attr.borderColor = Qt.binding( function(){ return STheme.progress_bar_warning_bg; });
            }
        }
    }
}
