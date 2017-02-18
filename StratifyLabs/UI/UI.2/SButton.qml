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
import StratifyLabs.UI 2.0

Button {
    id: control

    property alias style: attr.style;
    property alias span: attr.span;
    property alias attr: attr;

    //additional properties
    property alias label: control.text;
    property string icon;
    property alias iconItem: contentIcon;

    implicitWidth: contentItem.implicitWidth + attr.paddingHorizontal*2;
    implicitHeight: attr.fontContainerHeight;
    baselineOffset: contentItem.y + contentItem.baselineOffset;

    topPadding: attr.paddingVertical;
    bottomPadding: attr.paddingVertical;
    leftPadding: attr.paddingHorizontal;
    rightPadding: attr.paddingHorizontal;



    property real nakedOpacity: 1.0;
    property real hoveredOpacity: 1.0;
    property real pressedOpacity: 1.0;

    contentItem:  SIcon {
        id: contentIcon;
        icon: control.icon;
        label: control.text;
        attr.style: control.attr.style;
        attr.fontColor: control.attr.fontColor;
        attr.fontColorMuted: control.attr.fontColorMuted;
        attr.fontSize: control.attr.fontSize;
        attr.fontWeight: control.attr.fontWeight;
    }

    background: Rectangle {
        color: {
            if( !enabled ){
                return attr.colorDisabled;
            }

            if( control.pressed ){
                return attr.colorPressed;
            }

            if( control.hovered ){
                return attr.colorHovered;
            }

            return attr.color;
        }
        border.color: enabled ? attr.borderColor : attr.colorDisabled;
        border.width: attr.borderWidth;
        radius: attr.radius;
        opacity: {
            if( control.pressed ){
                return control.pressedOpacity;
            }

            if( control.hovered ){
                return control.hoveredOpacity;
            }

            return control.nakedOpacity;
        }
    }


    SAttributes {
        id: attr;
        type: "button";

        color: STheme.btn_primary_bg;
        borderColor: STheme.btn_primary_border;
        fontColor: STheme.btn_primary_color;
        radius: STheme.btn_border_radius_base;

        onStyleChanged: {
            var items = parseStyle();
            control.pressedOpacity = 1.0;
            control.hoveredOpacity = 1.0;
            control.opacity = 1.0;
            for(var i = 0; i < items.length; i++){
                if( (items[i] === "btn-primary") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_primary_bg; });
                    attr.fontColor = Qt.binding(function(){ return STheme.btn_primary_color; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_primary_border; });
                    attr.textColorMuted = "#fff";
                    attr.colorHovered = Qt.binding(function(){ return Qt.darker(attr.color, 1.1); });
                } else if( (items[i] === "btn-outline-primary") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_primary_color; });
                    attr.fontColor = Qt.binding(function(){ if( control.hovered || control.pressed ){ return STheme.btn_primary_color; } return STheme.btn_primary_bg; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_primary_border; });
                    attr.textColorMuted = "#fff";
                    attr.colorHovered = Qt.binding(function(){ return STheme.btn_primary_bg; });
                } else if( (items[i] === "btn-default") || (items[i] === "btn-secondary") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_secondary_bg; });
                    attr.textColor = Qt.binding(function(){ return STheme.btn_secondary_color; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_secondary_border; });
                    attr.textColorMuted = Qt.binding(function(){ return STheme.text_muted; });
                    attr.colorHovered = Qt.binding(function(){ return Qt.darker(attr.color, 1.1); });
                } else if( (items[i] === "btn-outline-default") || (items[i] === "btn-outline-secondary") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_secondary_color; });
                    attr.fontColor = Qt.binding(function(){ if( control.hovered || control.pressed ){ return STheme.btn_secondary_color; } return STheme.btn_secondary_bg; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_secondary_border; });
                    attr.textColorMuted = Qt.binding(function(){ return STheme.text_muted; });;
                    attr.colorHovered = Qt.binding(function(){ return STheme.btn_secondary_bg; });
                } else if( (items[i] === "btn-danger") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_danger_bg; });
                    attr.textColor = Qt.binding(function(){ return STheme.btn_danger_color; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_danger_border; });
                    attr.textColorMuted = "#fff";
                    attr.colorHovered = Qt.binding(function(){ return Qt.darker(attr.color, 1.1); });
                } else if( (items[i] === "btn-outline-danger") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_danger_color; });
                    attr.fontColor = Qt.binding(function(){ if( control.hovered || control.pressed ){ return STheme.btn_danger_color; } return STheme.btn_danger_bg; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_danger_border; });
                    attr.textColorMuted = "#fff";
                    attr.colorHovered = Qt.binding(function(){ return STheme.btn_danger_bg; });
                } else if( (items[i] === "btn-success") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_success_bg; });
                    attr.textColor = Qt.binding(function(){ return STheme.btn_success_color; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_success_border; });
                    attr.textColorMuted = "#fff";
                    attr.colorHovered = Qt.binding(function(){ return Qt.darker(attr.color, 1.1); });
                } else if( (items[i] === "btn-outline-success") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_success_color; });
                    attr.fontColor = Qt.binding(function(){ if( control.hovered || control.pressed ){ return STheme.btn_success_color; } return STheme.btn_success_bg; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_success_border; });
                    attr.textColorMuted = "#fff";
                    attr.colorHovered = Qt.binding(function(){ return STheme.btn_success_bg; });
                } else if( (items[i] === "btn-info") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_info_bg; });
                    attr.textColor = Qt.binding(function(){ return STheme.btn_info_color; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_info_border; });
                    attr.textColorMuted = "#fff";
                    attr.colorHovered = Qt.binding(function(){ return Qt.darker(attr.color, 1.1); });
                } else if( (items[i] === "btn-outline-info") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_info_color; });
                    attr.fontColor = Qt.binding(function(){ if( control.hovered || control.pressed ){ return STheme.btn_info_color; } return STheme.btn_info_bg; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_info_border; });
                    attr.textColorMuted = "#fff";
                    attr.colorHovered = Qt.binding(function(){ return STheme.btn_info_bg; });
                } else if( (items[i] === "btn-warning") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_warning_bg; });
                    attr.textColor = Qt.binding(function(){ return STheme.btn_warning_color; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_warning_border; });
                    attr.textColorMuted = "#fff";
                    attr.colorHovered = Qt.binding(function(){ return Qt.darker(attr.color, 1.1); });
                } else if( (items[i] === "btn-outline-warning") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_warning_color; });
                    attr.fontColor = Qt.binding(function(){ if( control.hovered || control.pressed ){ return STheme.btn_warning_color; } return STheme.btn_warning_bg; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_warning_border; });
                    attr.textColorMuted = "#fff";
                    attr.colorHovered = Qt.binding(function(){ return STheme.btn_warning_bg; });
                } else if( (items[i] === "btn-naked") ){
                    control.pressedOpacity = 0.25;
                    control.hoveredOpacity = 0.1;
                    control.nakedOpacity = 0.0;
                    attr.color = "#000";
                    attr.fontColor = Qt.binding(function(){ return STheme.text_color; });
                    attr.borderColor = attr.color;
                    attr.textColorMuted = attr.fontColor;
                    attr.colorHovered = attr.color;
                } else if( (items[i] === "btn-close") ){
                    attr.color = "transparent";
                    attr.textColor = Qt.binding(function(){ return STheme.text_muted; });
                    attr.borderColor = "transparent";
                    attr.textColorMuted = Qt.binding(function(){ return STheme.text_muted; });
                }
            }
        }
    }
}
