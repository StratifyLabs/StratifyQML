import QtQuick 2.0

SItem {
    default property alias data: contents.data;

    implicitWidth: parent.width;
    implicitHeight: parent.height;

    Flickable {
        id: contents;

        width: parent.width;
        height: parent.height;

        contentWidth: 800;
        contentHeight: 800;

    }

}
