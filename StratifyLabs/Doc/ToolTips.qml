import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "ToolTips";
    EHeading {
        title: "Buttons";
        inherits: "QtQuick.Controls 2.0 Button";
        stratifyName: "SButton";
        specialAttibutes: "icon";
    }

    SLabel { style: "left"; text: "ToolTip Examples:"; }

    ToolTipExample{}
    ECodeExample { source: "ToolTipExample"; }
}
