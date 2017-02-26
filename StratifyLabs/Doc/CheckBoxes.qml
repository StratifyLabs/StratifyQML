import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "CheckBoxes";
    EHeading {
        title: "Check Boxes";
        inherits: "QtQuick.Controls 2.0 CheckBox";
        stratifyName: "SCheckBox";
    }
    ESectionTitle { text: "Description"; }

    SHLine{}

    ESectionTitle { text: "Example"; }
    CheckBoxExample{}
    ECodeExample { source: "CheckBoxExample"; }

    ESectionTitle { text: "Custom Icons"; }
    CheckBoxExampleCustom{}
    ECodeExample { source: "CheckBoxExampleCustom"; }
}
