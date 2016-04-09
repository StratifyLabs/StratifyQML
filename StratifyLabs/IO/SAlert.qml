import QtQuick 2.6
import "SCustomize.js" as Theme

STextWrap {
    type: "alert";

    bg_color: Theme.alert_info_bg;
    text_color: Theme.alert_info_text;
    border_color: Theme.alert_info_border;
    radius: Theme.alert_border_radius;

    padding_vertical: Theme.alert_padding;
    padding_horizontal: Theme.alert_padding;

    onStyleChanged: {
        var items = style.split(" ");
        for(var i = 0; i < items.length; i++){
            if( items[i] === "danger" ){
                bg_color = Theme.alert_danger_bg;
                text_color = Theme.alert_danger_text;
                border_color = Theme.alert_danger_border;
            } else if( items[i] === "success" ){
                bg_color = Theme.alert_success_bg;
                text_color = Theme.alert_success_text;
                border_color = Theme.alert_success_border;
            } else if( items[i] === "info" ){
                bg_color = Theme.alert_info_bg;
                text_color = Theme.alert_info_text;
                border_color = Theme.alert_info_border;
            } else if( items[i] === "warning" ){
                bg_color = Theme.alert_warning_bg;
                text_color = Theme.alert_warning_text;
                border_color = Theme.alert_warning_border;
            }
        }
    }

}
