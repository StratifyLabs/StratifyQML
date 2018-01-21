import QtQuick 2.6
import StratifyLabs.UI 1.0

SText {
    style: "fa";

    onStyleChanged: {
        var items = parseStyle();
        for(var i=0; i < items.length; i++){
            if( items[i] === "fa-spin" ){
                hideOnSm = true;
            }
        }
    }


}
