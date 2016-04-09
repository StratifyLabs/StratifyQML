import QtQuick 2.5
import "SCustomize.js" as Theme

SBaseRectangleText {

    // TODO Badge font size and padding need to be smaller -- need to check bootstrap code

    type: "badge";
    radius: Theme.badge_border_radius;
    bg_color: Theme.badge_bg;
    text_color: Theme.badge_color;
    border.color: Theme.badge_bg;

    onStyleChanged: {
        var items = style.split(" ");
        for(var i = 0; i < items.length; i++){
            if( items[i] === "active" ){
                bg_color = Theme.badge_active_bg;
                text_color = Theme.badge_active_color;
                border.color = Theme.badge_active_bg;
            }
        }
    }
}
