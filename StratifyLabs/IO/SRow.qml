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

    GridLayout {
        property alias item: row.item;
        rowSpacing: Theme.padding_base_horizontal;
        rows: 1;
        id: contents;
        width: parent.width;
        onWidthChanged: {
            for(var i = 0; i < children.length; i++){
                var w;
                if( children[i].span !== undefined ){
                    if( children[i].span > 0 ){
                        w = (width - (children.length-1)*rowSpacing) * children[i].span / Theme.grid_columns;
                        if( w > children[i].implicitWidth ){
                            children[i].Layout.preferredWidth = w;
                        }
                        if( children[i].type === "column" ){
                            children[i].resize(w);
                        }
                    }
                }

                if( children[i].alignment !== undefined ){
                    children[i].Layout.alignment = children[i].alignment;
                }
            }
        }
    }
}

