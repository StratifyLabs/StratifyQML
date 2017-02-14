import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Theme";
    style: "fill";
    SPane {
        style: "block fill";
        SColumn {
            SText { style: "left text-bold"; text: "Introduction"; }
            SText { style: "block"; text: 'StratifyLabs UI themes are based on the \
STheme object which defines colors, fonts, spacing, and shapes for the application.'; }
        }

    }
}
