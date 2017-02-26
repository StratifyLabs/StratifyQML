import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "Columns";
    EHeading {
        title: "Columns";
        inherits: "SRow";
        stratifyName: "SColumn";
        defaultSize: "block";
    }

    ESectionTitle { text: "Description"; }
    SText { style: "block"; text: 'An SColumn is similar to an SRow but it assumes \
all of its children span the entire width (which is the default value). SColumn does not \
respond to changes in screen size like SRow does.'; }

    SHLine{}

    ESectionTitle { text: "Example"; }
    ColumnExample{}
    ECodeExample { source: "ColumnExample"; }
}
