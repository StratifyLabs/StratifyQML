import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "Badges";
    EHeading {
        title: "Badges";
        inherits: "Rectangle";
        stratifyName: "SBadge";
        specialAttibutes: "icon";
    }

    SLabel { style: "left"; text: "Badge Colors:"; }

    BadgeExampleColors{}
    ECodeExample { source: "BadgeExampleColors"; }

    SHLine{}

    SLabel { style: "left"; text: "Badge Outlines:"; }

    BadgeExampleOutlineColors{}
    ECodeExample { source: "BadgeExampleOutlineColors"; }

    SHLine{}

    SLabel { style: "left"; text: "Icons:"; }

    BadgeExampleIcons{}
    ECodeExample { source: "BadgeExampleIcons"; }

    SHLine{}

    SLabel { style: "left"; text: "Button Sizes:"; }

    BadgeExampleSizes{}
    ECodeExample { source: "BadgeExampleSizes"; }
}


