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

    ESectionTitle { text: "Description"; }

    SText { style: "block"; text: '\
An SBadge is used as a decorative object to \
emphasize meaning to a small amount of information. \
An SBadge is always circular. It is only useful in showing
one or two digits or an icon.';
        }

    SHLine{}

    ESectionTitle { text: "Colors"; }
    BadgeExampleColors{}
    ECodeExample { source: "BadgeExampleColors"; }

    ESectionTitle { text: "Outlines"; }
    BadgeExampleOutlineColors{}
    ECodeExample { source: "BadgeExampleOutlineColors"; }

    ESectionTitle { text: "Icons"; }
    BadgeExampleIcons{}
    ECodeExample { source: "BadgeExampleIcons"; }

    ESectionTitle { text: "Sizes"; }
    BadgeExampleSizes{}
    ECodeExample { source: "BadgeExampleSizes"; }
}


