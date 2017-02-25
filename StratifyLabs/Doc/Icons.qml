import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "Icons";
    EHeading {
        title: "Icons";
        inherits: "Item";
        stratifyName: "SIcon";
        defaultSize: "block";
    }

    SLabel { style: "left"; text: "Icon Examples:"; }
    IconExampleObjects{}
    ECodeExample { source: "IconExampleObjects"; }

    SLabel { style: "left"; text: "Other Icon Objects:"; }
    IconExampleOther{}
    ECodeExample { source: "IconExampleOther"; }
}
