import QtQuick 2.0
import QtQuick.Controls 2.1
import StratifyLabs.UI 2.0

Drawer {

    property alias style: properties.style;
    property alias span: properties.span;
    property alias properties: properties;

    SProperties {
        id: properties;
        backgroundColor: StratifyUI.body_bg;

        onStyleChanged: {
            var items = parseStyle();
            properties.radius = StratifyUI.btn_border_radius_base;
            for(var i = 0; i < items.length; i++){
                if( (items[i] === "primary") || (items[i] === "drawer-primary") ){
                    properties.backgroundColor = Qt.binding(function(){ return StratifyUI.btn_primary_bg; });
                    properties.textColor = Qt.binding(function(){ return StratifyUI.btn_primary_color; });
                    properties.borderColor = Qt.binding(function(){ return StratifyUI.btn_primary_border; });
                    properties.textColorMuted = "#fff";
                } else if( (items[i] === "outline-primary") || (items[i] === "drawer-outline-primary") ){
                    properties.backgroundColor = Qt.binding(function(){ return StratifyUI.btn_primary_color; });
                    properties.textColor = Qt.binding(function(){ return StratifyUI.btn_primary_bg; });
                    properties.borderColor = Qt.binding(function(){ return StratifyUI.btn_primary_border; });
                    properties.textColorMuted = "#fff";
                }
            }
        }
    }

    background: Rectangle {
        color: properties.backgroundColor;
    }




}
