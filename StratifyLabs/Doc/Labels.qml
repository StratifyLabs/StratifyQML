import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Labels";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {
            EHeading {
                title: "Labels";
                inherits: "QtQuick.Controls 2.0 Label";
                stratifyName: "SLabel";
            }

            SLabel { style: "left"; text: "Label Colors:"; }

            LabelExampleColors{}
            ECodeExample { source: "LabelExampleColors"; }

            SHLine{}

            SLabel { style: "left"; text: "Label Sizes:"; }

            LabelExampleSizes{}
            ECodeExample { source: "LabelExampleSizes"; }


            SHLine{}


            SLabel { style: "left"; text: "Naked Labels:"; }

            LabelExampleNaked{}
            ECodeExample { source: "LabelExampleNaked"; }

        }
    }
}
