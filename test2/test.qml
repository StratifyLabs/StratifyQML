import QtQuick 2.6
import QtQuick.Window 2.2
import StratifyLabs.UI 2.0


Window {
    minimumWidth: STheme.screen_xs;
    minimumHeight: STheme.screen_xs;

    width: 400;
    height: 600;

    STest{}

    onWidthChanged: {
        STheme.updateScreenSize(width);
    }

    Component.onCompleted: {
        STheme.brand_primary = "#244E99";
    }
}
