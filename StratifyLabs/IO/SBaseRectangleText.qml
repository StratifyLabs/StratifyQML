import QtQuick 2.6
import "SCustomize.js" as Theme

SBaseRectangle {
    id: baseRectangleText;

    property string icon;
    property string text;
    property alias textObject: baseRectangleTextText;
    property bool hideTextOnSkinny: true;

    //size the rectangle based on the size of the text box
    implicitHeight: font_size + Theme.padding_base_vertical*3;
    implicitWidth: baseRectangleTextText.width;

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


    Row {
        id: baseRectangleTextText;
        anchors.centerIn: parent;

        leftPadding: padding_horizontal;
        rightPadding: padding_horizontal;
        bottomPadding: padding_vertical;
        topPadding: padding_vertical;
        spacing: Theme.padding_base_horizontal/4;

        Text {
            id: rectangleIcon;
            color: text_color;
            text: icon;
            font.pointSize: font_size;
            font.family: fontawesome.name;
            font.weight: Font.Light;
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
            height: rectangleText.height;
        }

        Text {
            id: rectangleText;
            color: text_color;
            text: baseRectangleText.text;
            font.pointSize: font_size;
            font.family: openSansLight.name;
            font.weight: Font.Light;
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
            visible: (icon !== "") && (hideTextOnSkinny) ? !skinny : true;
        }
    }
}
