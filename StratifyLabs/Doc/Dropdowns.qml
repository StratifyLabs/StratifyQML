import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "Dropdowns";
    EHeading {
        title: "Text Line Input";
        inherits: "QtQuick.Controls 2.0 ComboBox";
        stratifyName: "SDropdown or SDropup";
        defaultSize: "block";
    }

    ESectionTitle { text: "Description"; }

    SHLine{}

    ESectionTitle { text: "Example"; }
    DropdownExample{}
    ECodeExample { source: "DropdownExample"; }

    ESectionTitle { text: "Dropup"; }
    SText {
        style: "block";
        text: 'You can use "SDropup" if the combo box is at the bottom of the window.'
    }
    ECodeExample { source: "DropupExample"; }
    DropupExample{}

}
