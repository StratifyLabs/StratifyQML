import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Badges";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {
            ElementHeading {
                title: "Badges";
                inherits: "Rectangle";
                stratifyName: "SBadge";
                specialAttibutes: "icon";
            }

            SLabel { style: "left"; text: "Badge Colors:"; }

            BadgeExampleColors{}
            CodeExample { source: "BadgeExampleColors"; }

            SHLine{}

            SLabel { style: "left"; text: "Badge Outlines:"; }

            BadgeExampleOutlineColors{}
            CodeExample { source: "BadgeExampleOutlineColors"; }

            SHLine{}

            SLabel { style: "left"; text: "Icons:"; }

            BadgeExampleIcons{}
            CodeExample { source: "BadgeExampleIcons"; }

            SHLine{}

            SLabel { style: "left"; text: "Button Sizes:"; }

            BadgeExampleSizes{}
            CodeExample { source: "BadgeExampleSizes"; }
        }
    }
}
