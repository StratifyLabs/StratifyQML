import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Wells";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {
            EHeading {
                title: "Wells";
                inherits: "Rectangle";
                stratifyName: "SWell";
            }

            SLabel { style: "left"; text: "Well Examples:"; }

        }
    }
}
