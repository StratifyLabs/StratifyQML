import QtQuick 2.6
import "SCustomize.js" as Theme

SBaseRectangle {
    id: baseRectangleText;

    property string icon;
    property string text;
    property alias textObject: baseRectangleTextText;

    //size the rectangle based on the size of the text box
    height: baseRectangleTextText.height;
    width: baseRectangleTextText.width;

    onStyleChanged: {
        var items = style.split(" ");
        for(var i=0; i < items.length; i++){
            if( items[i] === "text-left" ){
                baseRectangleTextText.horizontalAlignment = Text.AlignLeft;
            } else if( items[i] === "text-right" ){
                baseRectangleTextText.horizontalAlignment = Text.AlightRight;
            } else if( items[i] === "text-center" ){
                baseRectangleTextText.horizontalAlignment = Text.AlignHCenter;
            } else if( items[i] === "fa" ){
                baseRectangleTextText.font.family = fontawesome.name;
                baseRectangleTextText.font.pointSize *= 1.15;
            } else if( items[i] === "bold" ){
                baseRectangleTextText.font.weight = Font.Bold;
            }
        }
    }

    Text {
        id: baseRectangleTextText;
        color: text_color;
        anchors.centerIn: parent;
        text: icon !== "" ? icon + " " + baseRectangleText.text : baseRectangleText.text;
        leftPadding: padding_horizontal;
        rightPadding: padding_horizontal;
        bottomPadding: padding_vertical;
        topPadding: padding_vertical;
        font.pointSize: font_size;
        font.family: openSansLight.name;
        font.weight: Font.Light;
        horizontalAlignment: Text.AlignHCenter;
        verticalAlignment: Text.AlignVCenter;
    }

}
