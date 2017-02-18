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

    property bool hideSm: false;

    //legacy 1.0 names
    property alias blockWidth: object.fillWidth;


    function parseStyle(){ return style.split(" "); }

    onStyleChanged: {
        var items = parseStyle();
        for(var i=0; i < items.length; i++){
            if( (items[i] === "implicit-size") || (items[i] === "default") ){
                fillWidth = false;
                fillHeight = false;
                alignment = Qt.AlignHCenter | Qt.AlignVCenter;
            } else if( items[i] === "hide-sm" ){
                hideSm = true;
            } else if( items[i] === "fill" ){
                fillHeight = true;
            } else if( items[i] === "block" ){
                blockWidth = true;
            } else if( items[i] === "top" ){
                alignment &= ~(Qt.AlignBottom | Qt.AlignVCenter);
                alignment |= Qt.AlignTop;
            } else if( items[i] === "bottom" ){
                alignment &= ~(Qt.AlignTop | Qt.AlignVCenter);
                alignment |= Qt.AlignBottom;
            } else if( items[i] === "middle" ){
                alignment &= ~(Qt.AlignBottom | Qt.AlignTop);
                alignment |= Qt.AlignVCenter;
            } else if( items[i] === "left" ){
                alignment &= ~(Qt.AlignRight | Qt.AlignHCenter);
                alignment |= Qt.AlignLeft;
            } else if( items[i] === "right" ){
                alignment &= ~(Qt.AlignLeft | Qt.AlignHCenter);
                alignment |= Qt.AlignRight;
            } else if( items[i] === "center" ){
                alignment &= ~(Qt.AlignLeft | Qt.AlignRight);
                alignment |= Qt.AlignHCenter;
            } else if( (items[i] === "condensed") || (items[i] === "padding-small") ){
                paddingVertical = Qt.binding( function() { return STheme.padding_small_vertical; });
                paddingHorizontal = Qt.binding( function() { return STheme.padding_small_horizontal; });
            } else if( items[i] === "padding-zero" ){
                paddingVertical = 0;
                paddingHorizontal = 0;
            } else if( items[i] === "padding-lg" ){
                paddingVertical = Qt.binding( function() { return STheme.padding_large_vertical; });
                paddingHorizontal = Qt.binding( function() { return STheme.padding_large_horizontal; });
            } else if( items[i] === "padding-xs" ){
                paddingVertical = Qt.binding( function() { return STheme.padding_xs_vertical; });
                paddingHorizontal = Qt.binding( function() { return STheme.padding_xs_horizontal; });
            }
        }
    }
}
