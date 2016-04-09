import QtQuick 2.5
import "SCustomize.js" as Theme

SBaseRectangleText {
    id: button;
    type: "btn";

    bg_color: Theme.btn_default_bg;
    text_color: Theme.btn_default_color;
    border_color: Theme.btn_default_border;

    onStyleChanged: {
        var items = style.split(" ");
        radius = Theme.btn_border_radius_base;
        for(var i = 0; i < items.length; i++){
            if( items[i] == "primary" ){
                bg_color = Theme.btn_primary_bg;
                text_color = Theme.btn_primary_color;
                border_color = Theme.btn_primary_border;
            } else if( items[i] == "default" ){
                bg_color = Theme.btn_default_bg;
                text_color = Theme.btn_default_color;
                border_color = Theme.btn_default_border;
            } else if( items[i] == "danger" ){
                bg_color = Theme.btn_danger_bg;
                text_color = Theme.btn_danger_color;
                border_color = Theme.btn_danger_border;
            } else if( items[i] == "success" ){
                bg_color = Theme.btn_success_bg;
                text_color = Theme.btn_success_color;
                border_color = Theme.btn_success_border;
            } else if( items[i] == "info" ){
                bg_color = Theme.btn_info_bg;
                text_color = Theme.btn_info_color;
                border_color = Theme.btn_info_border;
            } else if( items[i] == "warning" ){
                bg_color = Theme.btn_warning_bg;
                text_color = Theme.btn_warning_color;
                border_color = Theme.btn_warning_border;
            } else if( items[i] == "lg" ){
                radius = Theme.btn_border_radius_large;
            } else if( items[i] == "sm" ){
                radius = Theme.btn_border_radius_small;
            } else if( items[i] == "xs" ){
                radius = Theme.btn_border_radius_small;
            }
        }
    }

    MouseArea {
        anchors.fill: parent;
        hoverEnabled: true;
        onEntered: {
            bg_color = Qt.darker(bg_color, 1.1);
        }

        onExited: {
            bg_color = Qt.lighter(bg_color, 1.1);
        }
    }


}
