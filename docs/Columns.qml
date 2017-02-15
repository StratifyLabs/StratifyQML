import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Columns";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {
            ElementHeading {
                title: "Columns";
                inherits: "SRow";
                stratifyName: "SColumn";
                defaultSize: "block";
            }

            SText { style: "left text-bold"; text: "Description"; }
            SText { style: "block"; text: 'An SColumn is similar to an SRow but it assumes \
all of its children span the entire width (which is the default value). SColumn does not \
respond to changes in screen size like SRow does.'; }

            ColumnExample{}
            CodeExample { source: "ColumnExample"; }

        }
    }
}
