import QtQuick 2.0

SText {
    type: "textwrap";
    blockWidth: true;
    textObject.wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
    textObject.horizontalAlignment: Text.AlignLeft;
    textObject.width: parent.width;
    height: textObject.contentHeight + padding_vertical*2;
}
