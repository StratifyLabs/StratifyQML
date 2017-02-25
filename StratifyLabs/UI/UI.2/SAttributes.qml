import QtQuick 2.6
import StratifyLabs.UI 2.0

SSizeAttributes {
    id: object;

    //Text and font
    property string fontText: STheme.font_family_base.name;
    property string fontIcon: STheme.font_family_icon.name;
    property real fontSize: STheme.font_size_base;
    property real fontContainerHeight: (fontSize + paddingVertical*3);
    property color fontColor: STheme.text_color;
    property color fontColorHovered: fontColor;
    property color fontColorPressed: fontColor;
    property color fontColorSelected: STheme.text_muted;
    property real fontOpacity: 1.0;
    property color fontColorMuted: STheme.text_muted;
    property real fontHorizontalAlignment: Text.AlignHCenter;
    property real fontVerticalAlignment: Text.AlignVCenter;
    property real fontWeight: Font.Normal;
    property bool fontItalic: false;
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
    property alias radius: object.borderRadius;

    onStyleChanged: {
        var items = parseStyle();
        for(var i=0; i < items.length; i++){
            if( items[i] === "primary" ){
                fontColor = Qt.binding(function(){ return STheme.btn_primary_color; });
                color = Qt.binding(function(){ return STheme.btn_primary_bg; });
                borderColor = Qt.binding(function(){ return STheme.btn_primary_border; });
                colorHovered = Qt.binding(function(){ return Qt.darker(attr.color, 1.3); });
                colorPressed = Qt.binding(function(){ return Qt.darker(attr.colorHovered, 1.3); });
            } else if( items[i] === "secondary" ){
                fontColor = Qt.binding(function(){ return STheme.btn_secondary_color; });
                color = Qt.binding(function(){ return STheme.btn_secondary_bg; });
                borderColor = Qt.binding(function(){ return STheme.btn_secondary_border; });
                colorHovered = Qt.binding(function(){ return Qt.darker(attr.color, 1.3); });
                colorPressed = Qt.binding(function(){ return Qt.darker(attr.colorHovered, 1.3); });
            } else if( items[i] === "warning" ){
                fontColor = Qt.binding(function(){ return STheme.btn_warning_color; });
                color = Qt.binding(function(){ return STheme.btn_warning_bg; });
                borderColor = Qt.binding(function(){ return STheme.btn_warning_border; });
                colorHovered = Qt.binding(function(){ return Qt.darker(attr.color, 1.3); });
                colorPressed = Qt.binding(function(){ return Qt.darker(attr.colorHovered, 1.3); });
            } else if( items[i] === "danger" ){
                fontColor = Qt.binding(function(){ return STheme.btn_danger_color; });
                color = Qt.binding(function(){ return STheme.btn_danger_bg; });
                borderColor = Qt.binding(function(){ return STheme.btn_danger_border; });
                colorHovered = Qt.binding(function(){ return Qt.darker(attr.color, 1.3); });
                colorPressed = Qt.binding(function(){ return Qt.darker(attr.colorHovered, 1.3); });
            } else if( items[i] === "success" ){
                fontColor = Qt.binding(function(){ return STheme.btn_success_color; });
                color = Qt.binding(function(){ return STheme.btn_success_bg; });
                borderColor = Qt.binding(function(){ return STheme.btn_success_border; });
                colorHovered = Qt.binding(function(){ return Qt.darker(attr.color, 1.3); });
                colorPressed = Qt.binding(function(){ return Qt.darker(attr.colorHovered, 1.3); });
            } else if( items[i] === "info" ){
                fontColor = Qt.binding(function(){ return STheme.btn_info_color; });
                color = Qt.binding(function(){ return STheme.btn_info_bg; });
                borderColor = Qt.binding(function(){ return STheme.btn_info_border; });
                colorHovered = Qt.binding(function(){ return Qt.darker(attr.color, 1.3); });
                colorPressed = Qt.binding(function(){ return Qt.darker(attr.colorHovered, 1.3); });
            } else if( items[i] === "text-on-primary" ){
                fontColor = Qt.binding(function(){ return STheme.btn_primary_color; });
            } else if( items[i] === "text-on-secondary" ){
                fontColor = Qt.binding(function(){ return STheme.btn_secondary_color; });
            } else if( items[i] === "text-on-warning" ){
                fontColor = Qt.binding(function(){ return STheme.btn_warning_color; });
            } else if( items[i] === "text-on-success" ){
                fontColor = Qt.binding(function(){ return STheme.btn_success_color; });
            } else if( items[i] === "text-on-info" ){
                fontColor = Qt.binding(function(){ return STheme.btn_info_color; });
            } else if( items[i] === "text-on-danger" ){
                fontColor = Qt.binding(function(){ return STheme.btn_danger_color; });
            } else if( items[i] === "text-primary" ){
                fontColor = Qt.binding(function(){ return STheme.brand_primary; });
            } else if( items[i] === "text-warning" ){
                fontColor = Qt.binding(function(){ return STheme.brand_warning; });
            } else if( items[i] === "text-success" ){
                fontColor = Qt.binding(function(){ return STheme.brand_success; });
            } else if( items[i] === "text-info" ){
                fontColor = Qt.binding(function(){ return STheme.brand_info; });
            } else if( items[i] === "text-danger" ){
                fontColor = Qt.binding(function(){ return STheme.brand_danger; });
            } else if( items[i] === "text-secondary" ){
                fontColor = Qt.binding(function(){ return STheme.brand_secondary; });
            } else if( items[i] === "text-hide-sm" ){
                fontHideSm = true;
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
            } else if( items[i] === "text-bold" ){
                fontWeight = Font.Bold;
            } else if( items[i] === "text-light" ){
                fontWeight = Font.Light;
            } else if( (items[i] === "text-semi-bold") || items[i] === "text-demi-bold" ){
                fontWeight = Font.DemiBold;
            } else if( items[i] === "text-extra-bold" ){
                fontWeight = Font.ExtraBold;
            } else if( items[i] === "text-extra-light" ){
                fontWeight = Font.ExtraLight;
            } else if( items[i] === "text-normal" ){
                fontText = Qt.binding(function(){ return STheme.font_family_base.name; });
                fontWeight = Font.Normal;
                fontItalic = false;
            } else if( items[i] === "text-italic" ){
                fontItalic = true;
            } else if( items[i] === "text-lg" ){
                fontSize = Qt.binding( function() { return STheme.font_size_large; });
            } else if( items[i] === "text-sm" ){
                fontSize = Qt.binding( function() { return STheme.font_size_small; });
            } else if( items[i] === "text-h1" ){
                fontSize = Qt.binding( function() { return STheme.font_size_h1; });
            } else if( items[i] === "text-h2" ){
                fontSize = Qt.binding( function() { return STheme.font_size_h2; });
            } else if( items[i] === "text-h3" ){
                fontSize = Qt.binding( function() { return STheme.font_size_h3; });
            } else if( items[i] === "text-h4" ){
                fontSize = Qt.binding( function() { return STheme.font_size_h4; });
            } else if( items[i] === "text-h5" ){
                fontSize = Qt.binding( function() { return STheme.font_size_h5; });
            } else if( items[i] === "text-h6" ){
                fontSize = Qt.binding( function() { return STheme.font_size_h6; });
            } else if( items[i] === "lg" ){
                fontSize = Qt.binding( function() { return STheme.font_size_large; });
                paddingVertical = Qt.binding( function() { return STheme.padding_large_vertical; });
                paddingHorizontal = Qt.binding( function() { return STheme.padding_large_horizontal; });
                if( type === "button" ){
                    radius = Qt.binding(function(){ return STheme.btn_border_radius_large; });
                } else if(type !== "badge"){
                    radius = Qt.binding(function(){ return STheme.border_radius_large; });
                }
            } else if( items[i] === "sm" ){
                fontSize = Qt.binding( function() { return STheme.font_size_small; });
                paddingVertical = Qt.binding( function() { return STheme.padding_small_vertical; });
                paddingHorizontal = Qt.binding( function() { return STheme.padding_small_horizontal; });
                if( type === "button" ){
                    radius = Qt.binding(function(){ return STheme.btn_border_radius_small; });
                } else if(type !== "badge"){
                    radius = Qt.binding(function(){ return STheme.border_radius_small; });
                }
            } else if( items[i] === "xs" ){
                fontSize = Qt.binding( function() { return STheme.font_size_small; });
                paddingVertical = Qt.binding( function() { return STheme.padding_xs_vertical; });
                paddingHorizontal = Qt.binding( function() { return STheme.padding_xs_horizontal; });
                if( type === "button" ){
                    radius = Qt.binding(function(){ return STheme.btn_border_radius_small; });
                } else if(type !== "badge"){
                    radius = Qt.binding(function(){ return STheme.border_radius_small; });
                }
            }
        }
    }
}
