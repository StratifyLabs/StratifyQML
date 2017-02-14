import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Icons";
    style: "fill";
    SPane {
        style: "block fill";
        SColumn {
            SText { style: "left text-bold"; text: "Introduction"; }
            SText { style: "block"; text: 'StratifyLabs UI icons are based on the latest release of Font Awesome. \
The icons can be used using SIcon, SButton, and SBadge. You can also set the font.family of any text to "STheme.fontFontAwesome.name" \
to use the font in other objects.'; }
        }

    }
}
