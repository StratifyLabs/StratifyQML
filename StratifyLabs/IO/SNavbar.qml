import QtQuick 2.6
import "SCustomize.js" as Theme

Row {

    property var item: SItem {
        type: "navbar";
    }

    property var back; //navigation back in skinny mode
    property var details;

    spacing: Theme.padding_base_horizontal;
    anchors.horizontalCenter: parent.horizontalCenter;

    onWidthChanged: {
        //update item.skinny if width is below threshold
    }

    //when navbar is wide show buttons (and text if it fits)
    //when navbar is skinny (like on touchscreen) -- just show back button and last screen

}
