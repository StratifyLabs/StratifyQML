import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "ProgressCircles";
    EHeading {
        title: "Progress Circles";
        inherits: "Item";
        stratifyName: "SProgressBar";
    }

    SLabel { style: "left"; text: "ProgressCircle Colors"; }
    ProgressCircleExampleColors{}
    ECodeExample { source: "ProgressCircleExampleColors"; }

    SHLine{}

    SLabel { style: "left"; text: "Progress Circle with Icon"; }
    ProgressCircleExample{}
    ECodeExample { source: "ProgressCircleExample"; }
}
