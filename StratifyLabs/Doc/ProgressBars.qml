import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "ProgressBars";
    EHeading {
        title: "ProgressBars";
        inherits: "QtQuick.Controls 2.0 ProgressBar";
        stratifyName: "SProgressBar";
    }

    SLabel { style: "left"; text: "ProgressBar Colors:"; }
    ProgressBarExampleColors{}
    ECodeExample { source: "ProgressBarExampleColors"; }

    SHLine{}

    SLabel { style: "left"; text: "ProgressBar Sizes:"; }
    ProgressBarExampleSizes{}
    ECodeExample { source: "ProgressBarExampleSizes"; }
}
