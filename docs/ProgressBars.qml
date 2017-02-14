import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "ProgressBars";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {
            ElementHeading {
                title: "ProgressBars";
                inherits: "QtQuick.Controls 2.0 ProgressBar";
                stratifyName: "SProgressBar";
            }

            SLabel { style: "left"; text: "ProgressBar Colors:"; }
            ProgressBarExampleColors{}
            CodeExample { source: "ProgressBarExampleColors"; }

            SHLine{}

            SLabel { style: "left"; text: "Slider Sizes:"; }
            ProgressBarExampleSizes{}
            CodeExample { source: "ProgressBarExampleSizes"; }

        }
    }
}
