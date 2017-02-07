import QtQuick 2.6
import QtQuick.Window 2.2
import StratifyLabs.UI 2.0


Window {
    minimumWidth: StratifyUI.screen_xs;
    minimumHeight: StratifyUI.screen_xs;

    width: 400;
    height: 600;

    STest{}

    onWidthChanged: {
        StratifyUI.updateScreenSize(width);
    }

    Component.onCompleted: {
        StratifyUI.brand_primary = "#244E99";
    }
}
