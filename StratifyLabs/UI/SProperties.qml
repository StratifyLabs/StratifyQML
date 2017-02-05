import QtQuick 2.6
import "."

QtObject {
    id: object;
    property string style;
    property string type;

    //filling the width and height of the parent
    property bool blockWidth: false;
    property bool fillHeight: false;

    //these names are not consistent -- need to user camelcase -- and add a prefix sItemPaddingVertical;
    property real paddingVertical: StratifyUI.padding_base_vertical;
    property real paddingHorizontal: StratifyUI.padding_base_horizontal;

    property real span: StratifyUI.grid_columns;

    //Text and font
    property string fontText: StratifyUI.font_family_base.name;
    property string fontIcon: StratifyUI.font_family_icon.name;
    property real fontSize: StratifyUI.font_size_base;
    property real fontContainerHeight: (fontSize + paddingVertical*3);
    property color fontColor: StratifyUI.text_color;
    property real fontOpacity: 1.0;
    property color fontColorMuted: StratifyUI.text_muted;
    property color fontColorSelected: StratifyUI.text_muted;
    property real fontHorizontalAlignment: Text.AlignHCenter;
    property real fontVerticalAlignment: Text.AlignVCenter;

    property real alignment: Qt.AlignHCenter | Qt.AlignVCenter;


    //1.0 legacy aliases
    property alias textFont: object.fontText;
    property alias textColor: object.fontColor
    property alias textColorMuted: object.fontColorMuted;
    property alias iconFont: object.fontIcon;
    property real textOpacity: object.fontOpacity;


    //Background and border
    property color backgroundColor: "transparent";
    property color backgroundColorSelection: StratifyUI.gray_lighter;
    property color backgroundColorDisabled: StratifyUI.gray_lighter;
    property real borderRadius: StratifyUI.btn_border_radius_base;
    property color borderColor: "transparent";
    property real borderWidth: StratifyUI.border_width;

    property alias radius: object.borderRadius;

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
            } else if( items[i] === "h1" ){
                fontSize = StratifyUI.font_size_h1;
            } else if( items[i] === "h2" ){
                fontSize = StratifyUI.font_size_h2;
            } else if( items[i] === "h3" ){
                fontSize = StratifyUI.font_size_h3;
            } else if( items[i] === "h4" ){
                fontSize = StratifyUI.font_size_h4;
            } else if( items[i] === "h5" ){
                fontSize = StratifyUI.font_size_h5;
            } else if( items[i] === "h6" ){
                fontSize = StratifyUI.font_size_h6;
            } else if( items[i] === "lg" ){
                fontSize = StratifyUI.font_size_large;
                paddingVertical = StratifyUI.padding_large_vertical;
                paddingHorizontal = StratifyUI.padding_large_horizontal;
            } else if( items[i] === "sm" ){
                fontSize = StratifyUI.font_size_small;
                paddingVertical = StratifyUI.padding_small_vertical;
                paddingHorizontal = StratifyUI.padding_small_horizontal;
            } else if( items[i] === "xs" ){
                fontSize = StratifyUI.font_size_small;
                paddingVertical = StratifyUI.padding_xs_vertical;
                paddingHorizontal = StratifyUI.padding_xs_horizontal;
            } else if( items[i] === "bold" ){
                textFont = StratifyUI.font_family_bold.name;
            }
        }
    }


}
