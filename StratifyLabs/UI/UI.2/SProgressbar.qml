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

    property alias style: properties.style;
    property alias span: properties.span;
    property alias properties: properties;
    property color progressColor: StratifyUI.progress_bar_color;

    SProperties {
        id: properties;
        blockWidth: true;
        backgroundColor: StratifyUI.body_bg;
        textColor: StratifyUI.progress_bar_color;
        borderColor: StratifyUI.progress_bar_bg;
        borderRadius: StratifyUI.progress_border_radius;
        borderWidth: StratifyUI.progress_border_width;
    }

    implicitWidth: 0;
    implicitHeight: properties.fontContainerHeight;

    contentItem: Rectangle {
        id: strip
        x: control.x;
        implicitWidth: 10;
        height: control.height;
        scale: control.mirrored ? -1 : 1
        color: properties.backgroundColor;
        radius: properties.borderRadius;
        border.color: properties.backgroundColor;

        Rectangle {
            color: progressColor;
            width: parent.width * control.value;
            height: parent.height;
            radius: properties.borderRadius;
        }

    }

    background: null;


    onStyleChanged: {
        var items = style.split(" ");
        for(var i = 0; i < items.length; i++){
            if( items[i] === "progress-bar-primary" ){
                progressColor = Qt.binding( function(){ return StratifyUI.progress_bar_bg; });
                properties.borderColor = Qt.binding( function(){ return StratifyUI.progress_bar_bg; });
            } else if( items[i] === "progress-bar-default" ){
                progressColor = Qt.binding( function(){ return StratifyUI.progress_bar_bg; });
                properties.borderColor = Qt.binding( function(){ return StratifyUI.progress_bar_bg; });
            } else if( items[i] === "progress-bar-danger" ){
                progressColor = Qt.binding( function(){ return StratifyUI.progress_bar_danger_bg; });
                properties.borderColor = Qt.binding( function(){ return StratifyUI.progress_bar_danger_bg; });
            } else if( items[i] === "progress-bar-success" ){
                progressColor = Qt.binding( function(){ return StratifyUI.progress_bar_success_bg; });
                properties.borderColor = Qt.binding( function(){ return StratifyUI.progress_bar_success_bg; });
            } else if( items[i] === "progress-bar-info" ){
                progressColor = Qt.binding( function(){ return StratifyUI.progress_bar_info_bg; });
                properties.borderColor = Qt.binding( function(){ return StratifyUI.progress_bar_info_bg; });
            } else if( items[i] === "progress-bar-warning" ){
                progressColor = Qt.binding( function(){ return StratifyUI.progress_bar_warning_bg; });
                properties.borderColor = Qt.binding( function(){ return StratifyUI.progress_bar_warning_bg; });
            }
        }
    }
}
