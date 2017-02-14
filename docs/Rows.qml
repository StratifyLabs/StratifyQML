import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Rows";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {
            ElementHeading {
                title: "Rows";
                inherits: "GridLayout";
                stratifyName: "SRow";
                defaultSize: "block";
            }

            SText { style: "left text-bold"; text: "Introduction"; }
            SText { style: "block"; text: 'An SRow arranges items in a row. \
If the items won\'t fit in the row, the items are arranged in a grid. Each row \
can have a total span of STheme.grid_columns (which defaults to a value of 12).
'; }

            ButtonExampleColors{}
            CodeExample { source: "ButtonExampleColors"; }

            SHLine{}

            SLabel { style: "left"; text: "Button Outlines:"; }

            ButtonExampleOutlineColors{}
            CodeExample { source: "ButtonExampleOutlineColors"; }

            SHLine{}

            SLabel { style: "left"; text: "Icons:"; }

            ButtonExampleIcons{}
            CodeExample { source: "ButtonExampleIcons"; }

            SHLine{}

            SLabel { style: "left"; text: "Button Sizes:"; }

            ButtonExampleSizes{}
            CodeExample { source: "ButtonExampleSizes"; }

            SHLine{}


            SLabel { style: "left"; text: "Naked Buttons:"; }

            ButtonExampleNaked{}
            CodeExample { source: "ButtonExampleNaked"; }

        }
    }
}
