import QtQuick 2.6
import StratifyLabs.UI 2.0

QtObject {
    id: object;
    property string style;
    property string type;

    //Grid and Spacing
    property bool fillWidth: false;
    property bool fillHeight: false;
    property real span: STheme.grid_columns;
    property real paddingVertical: STheme.padding_base_vertical;
    property real paddingHorizontal: STheme.padding_base_horizontal;
    property real alignment: Qt.AlignHCenter | Qt.AlignVCenter;

    property bool hideSm;

    //Text and font
    property string fontText: STheme.font_family_base.name;
    property string fontIcon: STheme.font_family_icon.name;
    property real fontSize: STheme.font_size_base;
    property real fontContainerHeight: (fontSize + paddingVertical*3);
    property color fontColor: STheme.text_color;

    //color of the font when selected
    property color fontColorSelected: STheme.text_muted;
    property real fontOpacity: 1.0;
    property color fontColorMuted: STheme.text_muted;
    property real fontHorizontalAlignment: Text.AlignHCenter;
    property real fontVerticalAlignment: Text.AlignVCenter;
    property real fontWeight: Font.Normal;
    property bool fontHideSm: false;

    //Color -- color of buttons, labels, panels, etc
    property color color: "transparent";
    property color colorHovered: Qt.darker(color, 1.3);
    property color colorPressed: Qt.darker(colorHovered, 1.3);
    property color colorDisabled: STheme.gray_lighter;

    //Background color for progress bars, sliders and text-boxes
    property color backgroundColor: "transparent";
    //property color backgroundColorHover: "transparent";
    property color backgroundColorFontSelection: STheme.gray_lighter;
    property color backgroundColorDisabled: STheme.gray_lighter;
    //property color backgroundColorPressed: Qt.darker(backgroundColorHover, 1.3);

    //Border
    property real borderRadius: STheme.btn_border_radius_base;
    property color borderColor: "transparent";
    property real borderWidth: STheme.border_width;

    //1.0 legacy aliases
    property alias textFont: object.fontText;
    property alias textColor: object.fontColor
    property alias textColorMuted: object.fontColorMuted;
    property alias iconFont: object.fontIcon;
    property real textOpacity: object.fontOpacity;
    property alias blockWidth: object.fillWidth;
    property alias radius: object.borderRadius;

    function parseStyle(){ return style.split(" "); }


    onStyleChanged: {
        var items = parseStyle();
        for(var i=0; i < items.length; i++){
            if( items[i] === "default" ){
                fillWidth = false;
                fillHeight = false;
                alignment = Qt.AlignHCenter | Qt.AlignVCenter;
            } else if( items[i] === "primary" ){
                fontColor = Qt.binding(function(){ return STheme.btn_primary_color; });
                backgroundColor = Qt.binding(function(){ return STheme.btn_primary_bg; });
                borderColor = Qt.binding(function(){ return STheme.btn_primary_border; });
                colorHovered = Qt.binding(function(){ return Qt.darker(attr.backgroundColor, 1.1); });
            } else if( items[i] === "secondary" ){
                fontColor = Qt.binding(function(){ return STheme.btn_secondary_color; });
                backgroundColor = Qt.binding(function(){ return STheme.btn_secondary_bg; });
                borderColor = Qt.binding(function(){ return STheme.btn_secondary_border; });
                colorHovered = Qt.binding(function(){ return Qt.darker(attr.backgroundColor, 1.1); });
            } else if( items[i] === "warning" ){
                fontColor = Qt.binding(function(){ return STheme.btn_warning_color; });
                backgroundColor = Qt.binding(function(){ return STheme.btn_warning_bg; });
                borderColor = Qt.binding(function(){ return STheme.btn_warning_border; });
                colorHovered = Qt.binding(function(){ return Qt.darker(attr.backgroundColor, 1.1); });
            } else if( items[i] === "danger" ){
                fontColor = Qt.binding(function(){ return STheme.btn_danger_color; });
                backgroundColor = Qt.binding(function(){ return STheme.btn_danger_bg; });
                borderColor = Qt.binding(function(){ return STheme.btn_danger_border; });
                colorHovered = Qt.binding(function(){ return Qt.darker(attr.backgroundColor, 1.1); });
            } else if( items[i] === "success" ){
                fontColor = Qt.binding(function(){ return STheme.btn_success_color; });
                backgroundColor = Qt.binding(function(){ return STheme.btn_success_bg; });
                borderColor = Qt.binding(function(){ return STheme.btn_success_border; });
                colorHovered = Qt.binding(function(){ return Qt.darker(attr.backgroundColor, 1.1); });
            } else if( items[i] === "info" ){
                fontColor = Qt.binding(function(){ return STheme.btn_info_color; });
                backgroundColor = Qt.binding(function(){ return STheme.btn_info_bg; });
                borderColor = Qt.binding(function(){ return STheme.btn_info_border; });
                colorHovered = Qt.binding(function(){ return Qt.darker(attr.backgroundColor, 1.1); });
            } else if( items[i] === "text-primary" ){
                fontColor = Qt.binding(function(){ return STheme.btn_primary_color; });
            } else if( items[i] === "text-secondary" ){
                fontColor = Qt.binding(function(){ return STheme.btn_secondary_color; });
            } else if( items[i] === "text-warning" ){
                fontColor = Qt.binding(function(){ return STheme.btn_warning_color; });
            } else if( items[i] === "text-success" ){
                fontColor = Qt.binding(function(){ return STheme.btn_success_color; });
            } else if( items[i] === "text-info" ){
                fontColor = Qt.binding(function(){ return STheme.btn_info_color; });
            } else if( items[i] === "text-danger" ){
                fontColor = Qt.binding(function(){ return STheme.btn_danger_color; });
            } else if( items[i] === "text-outline-primary" ){
                fontColor = Qt.binding(function(){ return STheme.brand_primary; });
            } else if( items[i] === "text-outline-warning" ){
                fontColor = Qt.binding(function(){ return STheme.brand_warning; });
            } else if( items[i] === "text-outline-success" ){
                fontColor = Qt.binding(function(){ return STheme.brand_success; });
            } else if( items[i] === "text-outline-info" ){
                fontColor = Qt.binding(function(){ return STheme.brand_info; });
            } else if( items[i] === "text-outline-danger" ){
                fontColor = Qt.binding(function(){ return STheme.brand_danger; });
            } else if( items[i] === "text-outline-secondary" ){
                fontColor = Qt.binding(function(){ return STheme.brand_secondary; });
            } else if( items[i] === "hide-sm" ){
                hideSm = true;
            } else if( items[i] === "text-hide-sm" ){
                fontHideSm = true;
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
            } else if( items[i] === "text-right" ){
                fontHorizontalAlignment = Text.AlignRight;
            } else if( items[i] === "text-left" ){
                fontHorizontalAlignment = Text.AlignLeft;
            } else if( items[i] === "text-center" ){
                fontHorizontalAlignment = Text.AlignHCenter;
            } else if( items[i] === "text-top" ){
                fontVerticalAlignment = Text.AlignTop;
            } else if( items[i] === "text-middle" ){
                fontVerticalAlignment = Text.AlignVCenter;
            } else if( items[i] === "text-bottom" ){
                fontVerticalAlignment = Text.AlignBottom;
            } else if( items[i] === "font-bold" ){
                fontWeight = Font.Bold;
            } else if( items[i] === "font-light" ){
                fontWeight = Font.Light;
            } else if( items[i] === "font-demi-bold" ){
                fontWeight = Font.DemiBold;
            } else if( items[i] === "font-extra-bold" ){
                fontWeight = Font.ExtraBold;
            } else if( items[i] === "font-extra-light" ){
                fontWeight = Font.ExtraLight;
            } else if( items[i] === "font-normal" ){
                fontWeight = Font.Normal;
            } else if( items[i] === "font-lg" ){
                fontSize = Qt.binding( function() { return STheme.font_size_large; });
            } else if( items[i] === "font-sm" ){
                fontSize = Qt.binding( function() { return STheme.font_size_small; });
            } else if( items[i] === "h1" ){
                fontSize = Qt.binding( function() { return STheme.font_size_h1; });
            } else if( items[i] === "h2" ){
                fontSize = Qt.binding( function() { return STheme.font_size_h2; });
            } else if( items[i] === "h3" ){
                fontSize = Qt.binding( function() { return STheme.font_size_h3; });
            } else if( items[i] === "h4" ){
                fontSize = Qt.binding( function() { return STheme.font_size_h4; });
            } else if( items[i] === "h5" ){
                fontSize = Qt.binding( function() { return STheme.font_size_h5; });
            } else if( items[i] === "h6" ){
                fontSize = Qt.binding( function() { return STheme.font_size_h6; });
            } else if( items[i] === "lg" ){
                fontSize = Qt.binding( function() { return STheme.font_size_large; });
                paddingVertical = Qt.binding( function() { return STheme.padding_large_vertical; });
                paddingHorizontal = Qt.binding( function() { return STheme.padding_large_horizontal; });
            } else if( items[i] === "sm" ){
                fontSize = Qt.binding( function() { return STheme.font_size_small; });
                paddingVertical = Qt.binding( function() { return STheme.padding_small_vertical; });
                paddingHorizontal = Qt.binding( function() { return STheme.padding_small_horizontal; });
            } else if( items[i] === "xs" ){
                fontSize = Qt.binding( function() { return STheme.font_size_small; });
                paddingVertical = Qt.binding( function() { return STheme.padding_xs_vertical; });
                paddingHorizontal = Qt.binding( function() { return STheme.padding_xs_horizontal; });
            } else if( items[i] === "condensed" ){
                paddingVertical = Qt.binding( function() { return STheme.padding_small_vertical; });
                paddingHorizontal = Qt.binding( function() { return STheme.padding_small_horizontal; });
            } else if( items[i] === "padding-zero" ){
                paddingVertical = 0;
                paddingHorizontal = 0;
            }
        }
    }
}
