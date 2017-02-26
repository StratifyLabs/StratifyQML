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

    ESectionTitle { text: "Description"; }

    SHLine{}

    ESectionTitle { text: "Example"; }
    IconExampleObjects{}
    ECodeExample { source: "IconExampleObjects"; }

    ESectionTitle { text: "Other Objects"; }
    IconExampleOther{}
    ECodeExample { source: "IconExampleOther"; }
}
