import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "Wells";
    EHeading {
        title: "Wells";
        inherits: "Rectangle";
        stratifyName: "SWell";
    }
    ESectionTitle { text: "Description"; }

    SHLine{}

    ESectionTitle { text: "Example"; }
    WellExample{}
    ECodeExample { source: "WellExample"; }
}
