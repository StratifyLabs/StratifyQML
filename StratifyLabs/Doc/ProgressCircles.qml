import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "ProgressCircles";
    EHeading {
        title: "Progress Circles";
        inherits: "Item";
        stratifyName: "SProgressCircle";
    }

    ESectionTitle { text: "Description"; }

    SHLine{}

    ESectionTitle { text: "Colors"; }
    ProgressCircleExampleColors{}
    ECodeExample { source: "ProgressCircleExampleColors"; }

    ESectionTitle { text: "With an Icon"; }
    ProgressCircleExample{}
    ECodeExample { source: "ProgressCircleExample"; }
}
