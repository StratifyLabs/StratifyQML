import QtQuick 2.5
import "SCustomize.js" as Theme

Item {
    id: self;
    property alias item: self;
    property string style;
    property string type: "item";
    property bool blockWidth: false;
    property real span: 1;
    property bool hideOnSkinny: false;
    property bool skinny: parent.item !== undefined ? parent.item.skinny : false;

    property real alignment: Qt.AlignTop | Qt.AlignLeft;

    visible: hideOnSkinny && skinny ? false : true;

    function parseStyle(){ return (style.replace("-", " ")).split(" "); }

    onStyleChanged: {
        var items = parseStyle();
        for(var i=0; i < items.length; i++){
            if( items[i] === "hide-sm" ){
                hideOnSkinny = true;
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
            }
        }
    }
}
