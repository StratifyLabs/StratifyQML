import QtQuick 2.0
import QtQuick.Controls 2.1
import StratifyLabs.UI 2.0

Drawer {

    property alias style: attr.style;
    property alias span: attr.span;
    property alias attr: attr;

    SAttributes {
        id: attr;
        color: STheme.body_bg;

        onStyleChanged: {
            var items = parseStyle();
            attr.radius = STheme.btn_border_radius_base;
            for(var i = 0; i < items.length; i++){
                if( (items[i] === "primary") || (items[i] === "drawer-primary") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_primary_bg; });
                    attr.textColor = Qt.binding(function(){ return STheme.btn_primary_color; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_primary_border; });
                    attr.textColorMuted = "#fff";
                } else if( (items[i] === "outline-primary") || (items[i] === "drawer-outline-primary") ){
                    attr.color = Qt.binding(function(){ return STheme.btn_primary_color; });
                    attr.textColor = Qt.binding(function(){ return STheme.btn_primary_bg; });
                    attr.borderColor = Qt.binding(function(){ return STheme.btn_primary_border; });
                    attr.textColorMuted = "#fff";
                }
            }
        }
    }

    background: Rectangle {
        color: attr.color;
    }




}
