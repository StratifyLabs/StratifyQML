import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "Labels";
    EHeading {
        title: "Labels";
        inherits: "QtQuick.Controls 2.0 Label";
        stratifyName: "SLabel";
    }
    ESectionTitle { text: "Description"; }

    SHLine{}

    ESectionTitle { text: "Colors"; }
    LabelExampleColors{}
    ECodeExample { source: "LabelExampleColors"; }

    ESectionTitle { text: "Sizes"; }
    LabelExampleSizes{}
    ECodeExample { source: "LabelExampleSizes"; }

    SLabel { style: "left"; text: "Naked Labels:"; }
    LabelExampleNaked{}
    ECodeExample { source: "LabelExampleNaked"; }

}
