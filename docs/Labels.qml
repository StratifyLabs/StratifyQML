import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Labels";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {
            ElementHeading {
                title: "Labels";
                inherits: "QtQuick.Controls 2.0 Label";
                stratifyName: "SLabel";
            }

            SLabel { style: "left"; text: "Label Colors:"; }

            LabelExampleColors{}
            CodeExample { source: "LabelExampleColors"; }

            SHLine{}

            SLabel { style: "left"; text: "Label Sizes:"; }

            LabelExampleSizes{}
            CodeExample { source: "LabelExampleSizes"; }


            SHLine{}


            SLabel { style: "left"; text: "Naked Labels:"; }

            LabelExampleNaked{}
            CodeExample { source: "LabelExampleNaked"; }

        }
    }
}
