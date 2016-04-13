import QtQuick 2.6
import QtQuick.Layouts 1.3
import "SCustomize.js" as Theme

SItem {
    id: column;
    default property alias data: contents.data;
    type: "column";

    anchors.top: parent.top;
    anchors.horizontalCenter: parent.horizontalCenter;
    implicitWidth: parent.width;
    implicitHeight: contents.childrenRect.height;

    ColumnLayout {
        property alias item: column.item;
        id: contents;
        anchors.fill: parent;
        spacing: Theme.padding_base_vertical;

        onWidthChanged: {
            for(var i=0; i < children.length; i++){
                var w = width - 2*Theme.padding_base_horizontal;
                children[i].Layout.width = w;
            }
        }
    }
}

