import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "ProgressBars";
    EHeading {
        title: "Progress Bars";
        inherits: "QtQuick.Controls 2.0 ProgressBar";
        stratifyName: "SProgressBar";
    }

    ESectionTitle { text: "Description"; }

    SHLine{}

    ESectionTitle { text: "Colors"; }
    ProgressBarExampleColors{}
    ECodeExample { source: "ProgressBarExampleColors"; }

    ESectionTitle { text: "Sizes"; }
    ProgressBarExampleSizes{}
    ECodeExample { source: "ProgressBarExampleSizes"; }
}
