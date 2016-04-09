import QtQuick 2.6
import QtQuick.Layouts 1.3
import "SCustomize.js" as Theme

GridLayout {
    id: row;

    property string type: "row";
    property bool blockWidth: true;
    property bool displayVertical;

    columns: Theme.grid_columns;
    columnSpacing: Theme.padding_base_horizontal;
    rowSpacing: Theme.padding_base_vertical;

    function updateAlignment(){
        for(var i=0; i < children.length; i++){
            var items = children[i].style.split(" ");
            for(var j=0; j < items.length; j++){
                children[i].Layout.alignment = Qt.AlignVCenter;
                if( items[j] === "left" ){
                    children[i].Layout.alignment |= Qt.AlignLeft;
                } else if( items[j] === "right" ){
                    children[i].Layout.alignment |= Qt.AlignRight;
                }
            }
        }
    }

    function resize(w){
        var columnWidth;
        var span = 12;
        var realChildren;

        if( w > Theme.screen_sm ){
            span = 1;
            displayVertical = false;
        } else {
            displayVertical = true;
            span = columns;
        }

        if( w > Theme.screen_lg ){
            width = Theme.screen_lg;
        } else {
            width = w;
        }

        realChildren = 0;
        for(var i=0; i < children.length; i++){
            if( children[i].type !== "rowspacer" ){
                realChildren++;
            }
        }

        for(var i=0; i < children.length; i++){
            var colWidth;
            if( span > children[i].span ){
                children[i].Layout.columnSpan = span;
                colWidth = width;
                if( children[i].blockWidth ){
                    children[i].Layout.preferredWidth = colWidth;
                }
            } else {
                children[i].Layout.columnSpan = children[i].span;
                colWidth = children[i].Layout.columnSpan *
                        (width - columnSpacing * (realChildren - 1)) / columns;
                if( children[i].blockWidth ){
                    children[i].Layout.preferredWidth = colWidth;
                }
            }

            if( children[i].type === "row" ){
                resize(colWidth)
            }
        }

    }


    Component.onCompleted: {
        updateAlignment();
    }


}

