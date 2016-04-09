import QtQuick 2.6
import "SCustomize.js" as Theme

SItem {
    id: baseRectangle;

    type: "base";
    blockWidth: false;

    property alias bg_color: baseRectangle.color;
    property string text_color: Theme.text_color;

    property real padding_vertical: Theme.padding_base_vertical;
    property real padding_horizontal: Theme.padding_base_horizontal;
    property real font_size: Theme.font_size_base;

    property real radius: Theme.btn_border_radius_base;
    property string color: Theme.body_bg;
    property string border_color: Theme.body_bg;

    Rectangle {
        anchors.fill: parent;
        radius: baseRectangle.radius;
        border.color: baseRectangle.border_color;
        color: baseRectangle.color;
    }

    onStyleChanged: {
        var items = style.split(" ");
        for(var i = 0; i < items.length; i++){
            if( items[i] == "lg" ){
                font_size = Theme.font_size_large;
                padding_vertical = Theme.padding_large_vertical;
                padding_horizontal = Theme.padding_large_horizontal;
            } else if( items[i] == "sm" ){
                font_size = Theme.font_size_small;
                padding_vertical = Theme.padding_small_vertical;
                padding_horizontal = Theme.padding_small_horizontal;
            } else if( items[i] == "xs" ){
                font_size = Theme.font_size_small;
                padding_vertical = Theme.padding_xs_vertical;
                padding_horizontal = Theme.padding_xs_horizontal;
            } else if( items[i] == "block" ){
                blockWidth = true;
            } else if( items[i] == "h1" ){
                font_size = Theme.font_size_h1;
            } else if( items[i] == "h2" ){
                font_size = Theme.font_size_h2;
            } else if( items[i] == "h3" ){
                font_size = Theme.font_size_h3;
            } else if( items[i] == "h4" ){
                font_size = Theme.font_size_h4;
            } else if( items[i] == "h5" ){
                font_size = Theme.font_size_h5;
            } else if( items[i] == "h6" ){
                font_size = Theme.font_size_h6;
            }
        }
    }
}
