import QtQuick 2.6
import QtQuick.Layouts 1.3
import "SCustomize.js" as Theme

SItem {
    id: row;
    type: "row";
    default property alias data: contents.data;
    skinny: width < Theme.screen_sm;

    implicitWidth: parent.width;
    implicitHeight: contents.childrenRect.height;

    Row {
        property alias item: row.item;
        spacing: Theme.padding_base_vertical;
        id: contents;
        anchors.fill: parent;

        onWidthChanged: {
            for(var i = 0; i < children.length; i++){
                var w;
                if( children[i].span !== undefined ){
                    if( children[i].span > 0 ){
                        w = width * children[i].span / Theme.grid_columns;
                        if( w > children[i].implicitWidth ){
                            children[i].width = w;
                        }
                    }
                }

                if( children[i].alignment !== undefined ){
                    console.log("Align " + children[i].alignment);
                    children[i].Layout.alignment = children[i].alignment;
                }
            }
        }

    }
}

