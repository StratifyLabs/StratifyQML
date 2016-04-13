import QtQuick 2.6
import QtQuick.Layouts 1.3
import "SCustomize.js" as Theme

SItem {
    id: column;
    default property alias data: contents.data;
    type: "column";

    implicitWidth: parent.width;
    implicitHeight: contents.childrenRect.height;

    function resize(w){
        contents.width = w;
    }

    ColumnLayout {
        property alias item: column.item;
        id: contents;

        width: parent.width;
        spacing: Theme.padding_base_vertical;

        onWidthChanged: {
            for(var i=0; i < children.length; i++){
                children[i].Layout.preferredWidth = width;
            }
        }
    }
}

