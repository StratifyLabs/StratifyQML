import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Dropdowns";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {

            SLabel { style: "left"; text: "Text Input Options:"; }

            EHeading {
                title: "Text Line Input";
                inherits: "QtQuick.Controls 2.0 ComboBox";
                stratifyName: "SDropdown or SDropup";
                defaultSize: "block";
            }

            SLabel { style: "left"; text: "Dropdown Examples:"; }

            DropdownExample{}
            ECodeExample { source: "DropdownExample"; }

            SHLine{}

            SLabel { style: "left"; text: "Dropup Example:"; }

            SText {
                style: "block";
                text: 'You can use "SDropup" if the combo box is at the bottom of the window.'
            }

            ECodeExample { source: "DropupExample"; }
            DropupExample{}
        }
    }
}
