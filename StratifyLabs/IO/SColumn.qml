import QtQuick 2.6
import QtQuick.Layouts 1.3
import "SCustomize.js" as Theme

ColumnLayout {
    id: row;

    property string type: "column";
    property bool blockWidth: true;

    Component.onCompleted: {
        for(var i=0; i < children.length; i++){
            children[i].Layout.preferredWidth = parent.width - 2*Theme.padding_base_horizontal;
            children[i].Layout.preferredHeight = children[i].childrenRect.height;
        }
    }


}

