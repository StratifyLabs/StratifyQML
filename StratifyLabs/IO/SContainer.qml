import QtQuick 2.6
import "SCustomize.js" as Theme

SItem {

    type: "container";

    width: parent.width - Theme.padding_base_horizontal*2;
    height: childrenRect.height;
    anchors.horizontalCenter: parent.horizontalCenter;
    anchors.topMargin: Theme.padding_base_vertical;
    anchors.bottomMargin: Theme.padding_base_vertical;

    onWidthChanged: {
        for(var i=0; i < children.length; i++){
            if( children[i].type === "row" ){
                children[i].resize(width);
            }
        }
    }


}
