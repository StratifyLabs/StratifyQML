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

import QtQuick 2.8
import QtQuick.Controls 2.1
import "."

Button {
    id: control

    property alias style: properties.style;
    property alias span: properties.span;
    property alias properties: properties;
    property string icon;


    property alias spin: icon.spin;
    property alias pulse: icon.pulse;
    property alias pulseSteps: icon.pulseSteps;
    property alias animationPeriod: icon.animationPeriod;

    implicitWidth: contentItem.implicitWidth + properties.paddingHorizontal*2;
    implicitHeight: properties.fontContainerHeight;
    baselineOffset: contentItem.y + contentItem.baselineOffset;

    topPadding: properties.paddingVertical;
    bottomPadding: properties.paddingVertical;
    leftPadding: properties.paddingHorizontal;
    rightPadding: properties.paddingHorizontal;

    contentItem:  SIcon {
        id: icon;
        icon: control.icon;
        label: control.text;
        properties.style: control.properties.style;
    }

    background: Rectangle {
        color: {
            if( !enabled ){
                return properties.backgroundColorDisabled;
            }

            if( control.pressed ){
                return Qt.darker(properties.backgroundColor, 1.3);
            }

            if( control.hovered ){
                return Qt.darker(properties.backgroundColor, 1.1);
            }

            return properties.backgroundColor;
        }
        border.color: enabled ? properties.borderColor : properties.backgroundColorDisabled;
        border.width: properties.borderWidth;
        radius: properties.radius;
    }


    SProperties {
        id: properties;
        type: "btn";

        onStyleChanged: {
            var items = parseStyle();
            properties.radius = StratifyUI.btn_border_radius_base;
            for(var i = 0; i < items.length; i++){
                if( (items[i] === "primary") || (items[i] === "btn-primary") ){
                    properties.backgroundColor = Qt.binding(function(){ return StratifyUI.btn_primary_bg; });
                    icon.properties.textColor = Qt.binding(function(){ return StratifyUI.btn_primary_color; });
                    properties.borderColor = Qt.binding(function(){ return StratifyUI.btn_primary_border; });
                    properties.textColorMuted = "#fff";
                } else if( (items[i] === "outline-primary") || (items[i] === "btn-outline-primary") ){
                    properties.backgroundColor = Qt.binding(function(){ return StratifyUI.btn_primary_color; });
                    icon.properties.textColor = Qt.binding(function(){ return StratifyUI.btn_primary_bg; });
                    properties.borderColor = Qt.binding(function(){ return StratifyUI.btn_primary_border; });
                    properties.textColorMuted = "#fff";
                } else if( items[i] === "default" || (items[i] === "btn-default") || (items[i] === "btn-secondary") ){
                    properties.backgroundColor = Qt.binding(function(){ return StratifyUI.btn_default_bg; });
                    icon.properties.textColor = Qt.binding(function(){ return StratifyUI.btn_default_color; });
                    properties.borderColor = Qt.binding(function(){ return StratifyUI.btn_default_border; });
                    properties.textColorMuted = Qt.binding(function(){ return StratifyUI.text_muted; });;
                } else if( items[i] === "outline-default" || (items[i] === "btn-outline-default") || (items[i] === "btn-outline-secondary") ){
                    properties.backgroundColor = Qt.binding(function(){ return StratifyUI.btn_default_color; });
                    icon.properties.textColor = Qt.binding(function(){ return StratifyUI.btn_default_bg; });
                    properties.borderColor = Qt.binding(function(){ return StratifyUI.btn_default_border; });
                    properties.textColorMuted = Qt.binding(function(){ return StratifyUI.text_muted; });;
                } else if( items[i] === "danger" || (items[i] === "btn-danger") ){
                    properties.backgroundColor = Qt.binding(function(){ return StratifyUI.btn_danger_bg; });
                    icon.properties.textColor = Qt.binding(function(){ return StratifyUI.btn_danger_color; });
                    properties.borderColor = Qt.binding(function(){ return StratifyUI.btn_danger_border; });
                    properties.textColorMuted = "#fff";
                } else if( items[i] === "outline-danger" || (items[i] === "btn-outline-danger") ){
                    properties.backgroundColor = Qt.binding(function(){ return StratifyUI.btn_danger_color; });
                    icon.properties.textColor = Qt.binding(function(){ return StratifyUI.btn_danger_bg; });
                    properties.borderColor = Qt.binding(function(){ return StratifyUI.btn_danger_border; });
                    properties.textColorMuted = "#fff";
                } else if( items[i] === "success" || (items[i] === "btn-success") ){
                    properties.backgroundColor = Qt.binding(function(){ return StratifyUI.btn_success_bg; });
                    icon.properties.textColor = Qt.binding(function(){ return StratifyUI.btn_success_color; });
                    properties.borderColor = Qt.binding(function(){ return StratifyUI.btn_success_border; });
                    properties.textColorMuted = "#fff";
                } else if( items[i] === "outline-success" || (items[i] === "btn-outline-success") ){
                    properties.backgroundColor = Qt.binding(function(){ return StratifyUI.btn_success_color; });
                    icon.properties.textColor = Qt.binding(function(){ return StratifyUI.btn_success_bg; });
                    properties.borderColor = Qt.binding(function(){ return StratifyUI.btn_success_border; });
                    properties.textColorMuted = "#fff";
                } else if( items[i] === "info" || (items[i] === "btn-info") ){
                    properties.backgroundColor = Qt.binding(function(){ return StratifyUI.btn_info_bg; });
                    icon.properties.textColor = Qt.binding(function(){ return StratifyUI.btn_info_color; });
                    properties.borderColor = Qt.binding(function(){ return StratifyUI.btn_info_border; });
                    properties.textColorMuted = "#fff";
                } else if( items[i] === "outline-info" || (items[i] === "btn-outline-info") ){
                    properties.backgroundColor = Qt.binding(function(){ return StratifyUI.btn_info_color; });
                    icon.properties.textColor = Qt.binding(function(){ return StratifyUI.btn_info_bg; });
                    properties.borderColor = Qt.binding(function(){ return StratifyUI.btn_info_border; });
                    properties.textColorMuted = "#fff";
                } else if( items[i] === "warning" || (items[i] === "btn-warning") ){
                    properties.backgroundColor = Qt.binding(function(){ return StratifyUI.btn_warning_bg; });
                    icon.properties.textColor = Qt.binding(function(){ return StratifyUI.btn_warning_color; });
                    properties.borderColor = Qt.binding(function(){ return StratifyUI.btn_warning_border; });
                    properties.textColorMuted = "#fff";
                } else if( items[i] === "outline-warning" || (items[i] === "btn-outline-warning") ){
                    properties.backgroundColor = Qt.binding(function(){ return StratifyUI.btn_warning_color; });
                    icon.properties.textColor = Qt.binding(function(){ return StratifyUI.btn_warning_bg; });
                    properties.borderColor = Qt.binding(function(){ return StratifyUI.btn_warning_border; });
                    properties.textColorMuted = "#fff";
                } else if( items[i] === "close" || (items[i] === "btn-close")){
                    backgroundColor = "transparent";
                    icon.properties.textColor = Qt.binding(function(){ return StratifyUI.text_muted; });
                    borderColor = "transparent";
                    properties.textColorMuted = Qt.binding(function(){ return StratifyUI.text_muted; });
                } else if( items[i] === "lg" || (items[i] === "btn-lg")){
                    properties.radius = Qt.binding(function(){ return StratifyUI.btn_border_radius_large; });
                    fontSize = Qt.binding(function(){ return StratifyUI.font_size_large; });
                    properties.paddingVertical = Qt.binding( function(){ return StratifyUI.padding_large_vertical; });
                    properties.paddingHorizontal = Qt.binding( function(){ return StratifyUI.padding_large_horizontal; });
                } else if( items[i] === "block" || (items[i] === "btn-block")){
                    blockWidth = true;
                } else if( items[i] === "sm" || (items[i] === "btn-sm")){
                    properties.paddingVertical = Qt.binding( function(){ return StratifyUI.padding_small_vertical; });
                    properties.paddingHorizontal = Qt.binding( function(){ return StratifyUI.padding_small_horizontal; });
                    properties.radius = Qt.binding(function(){ return StratifyUI.btn_border_radius_small; });
                    icon.properties.fontSize = Qt.binding(function(){ return StratifyUI.font_size_small; });
                } else if( items[i] === "xs" || (items[i] === "btn-xs")){
                    properties.paddingVertical = Qt.binding( function(){ return StratifyUI.padding_xs_vertical; });
                    properties.paddingHorizontal = Qt.binding( function(){ return StratifyUI.padding_xs_horizontal; });
                    properties.radius = Qt.binding(function(){ return StratifyUI.btn_border_radius_small; });
                    icon.properties.fontSize = Qt.binding(function(){ return StratifyUI.font_size_small; });
                }
            }
        }
    }
}
