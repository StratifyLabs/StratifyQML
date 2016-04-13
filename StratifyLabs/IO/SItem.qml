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

    visible: hideOnSkinny && skinny ? false : true;

    function parseStyle(){
        return style.split(" ");
    }

    onStyleChanged: {
        var items = parseStyle();
        for(var i=0; i < items.length; i++){
            if( items[i] === "hide-sm" ){
                hideOnSkinny = true;
            }
        }
    }
}
