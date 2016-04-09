import QtQuick 2.6
import "SCustomize.js" as Theme

SBaseRectangle {
    id: baseRectangleText;

    property alias text: input.text;
    property string placeholder: "placeholder";
    type: "input";

    blockWidth: true;

    color: Theme.input_bg;
    border_color: Theme.input_border;
    radius: Theme.input_border_radius;

    height: input.height;
    width: parent.width;

    onStyleChanged: {
        var items = style.split(" ");
        for(var i=0; i < items.length; i++){
            console.log("Update alignment " + items[i]);
            if( items[i] === "text-left" ){
                input.horizontalAlignment = TextEdit.AlignLeft;
            } else if( items[i] === "text-right" ){
                console.log("Align right");
                input.horizontalAlignment = TextEdit.AlightRight;
            } else if( items[i] === "text-center" ){
                input.horizontalAlignment = TextEdit.AlignHCenter;
            }
        }
    }


    TextEdit {
        id: input;
        color: text_color;
        anchors.centerIn: parent;
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
        selectionColor: Theme.input_group_addon_bg;
        selectedTextColor: Theme.text_muted;
    }

}
