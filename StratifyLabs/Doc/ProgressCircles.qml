import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "ProgressCircles";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {
            EHeading {
                title: "Progress Circles";
                inherits: "Item";
                stratifyName: "SProgressBar";
            }

            SLabel { style: "left"; text: "ProgressCircle Colors"; }
            ProgressBarExampleColors{}
            ECodeExample { source: "ProgressBarExampleColors"; }

            SHLine{}

            SLabel { style: "left"; text: "Other Examples"; }
            ProgressBarExampleSizes{}
            ECodeExample { source: "ProgressBarExampleSizes"; }

        }
    }
}
