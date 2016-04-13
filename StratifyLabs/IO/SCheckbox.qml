import QtQuick 2.6
import "SCustomize.js" as Theme
import "Fa-4.5.0.js" as Fa

SText {
    id: check;
    property bool checked;
    icon: checked ? Fa.Icon.check_square_o : Fa.Icon.square_o;
    text: "Checkbox";
    hideTextOnSkinny: false;

    signal clicked();

    MouseArea {
        anchors.fill: parent;
        onClicked: {
            check.checked = !check.checked;
            check.clicked();
        }
    }

}
