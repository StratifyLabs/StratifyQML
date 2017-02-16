import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Icons";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {
            EHeading {
                title: "Icons";
                inherits: "Item";
                stratifyName: "SIcon";
                defaultSize: "block";
            }

            SLabel { style: "left"; text: "Icon Examples:"; }


        }
    }
}
