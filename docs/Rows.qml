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
can have a total span of STheme.grid_columns (which defaults to a value of ' + STheme.grid_columns + ').'; }

            SText { style: "block"; text: "If you add the following code to your \
main application window, rows will automatically change to a grid when the screen is more \
narrow than STheme.screen_sm."; }

            SWell {
                text: 'onWidthChanged: {
        STheme.updateScreenSize(width);
}';
            }

            SText { style: "block"; text: 'With that code, SRow will change the \
number of columns from STheme.grid_columns (' + STheme.grid_columns + ') to STheme.grid_columns_sm \
(' + STheme.grid_columns_sm + ').'; }

            RowExampleResponsive{}
            CodeExample { source: "RowExampleResponsive"; }

            SText { style: "block"; text: 'You can customize when the change is triggered \
as well as the number of columns in each mode by adding the code below to the main "ApplicationWindow" \
object.'; }

            SWell {
                text: 'Component.onCompleted: {
        STheme.grid_columns_sm = 6;
        STheme.screen_sm = 600;
}';
            }

            SHLine{}

        }
    }
}
