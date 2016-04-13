import QtQuick 2.6
import "SCustomize.js" as Theme
import "Fa-4.5.0.js" as Fa

SBaseRectangle {
    id: baseRectangleInput;
    property alias text: input.text;
    property string placeholder: "placeholder";
    type: "input";
    blockWidth: true;
    color: Theme.input_bg;
    border_color: Theme.input_border;
    radius: Theme.input_border_radius;

    implicitHeight: font_size + Theme.padding_base_vertical*3;
    //implicitWidth: parent.width;

    onStyleChanged: {
        var items = style.split(" ");
        for(var i=0; i < items.length; i++){
            if( items[i] === "text-left" ){
                input.horizontalAlignment = Text.AlignLeft;
            } else if( items[i] === "text-right" ){
                input.horizontalAlignment = Text.AlignRight;
            } else if( items[i] === "text-center" ){
                input.horizontalAlignment = Text.AlignHCenter;
            }
        }
    }

    TextEdit {
        id: input;
        color: text_color;
        text: placeholder;
        width: parent.width;
        leftPadding: padding_horizontal;
        rightPadding: padding_horizontal;
        bottomPadding: padding_vertical;
        topPadding: padding_vertical;
        font.pointSize: font_size;
        font.family: Theme.font_family_base;
        horizontalAlignment: TextEdit.AlignLeft;
        verticalAlignment: TextEdit.AlignVCenter;
        selectByMouse: true;
        selectionColor: Qt.lighter(text_color, 3.0);
        selectedTextColor: text_color;
        clip: true;
    }

    Text {
        id: clearIcon;
        color: Theme.gray_lighter;
        text: Fa.Icon.times_circle;
        font.pointSize: font_size;
        anchors.right: parent.right;
        font.family: fontawesome.name;
        rightPadding: padding_horizontal;
        font.weight: Font.Light;
        horizontalAlignment: Text.AlignHCenter;
        verticalAlignment: Text.AlignVCenter;
        height: parent.height;
        visible: input.text !== "";


        MouseArea {
            anchors.fill: parent;
            onClicked: input.text = "";
        }
    }

}
