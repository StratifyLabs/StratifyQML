import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Inputs";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {

            SLabel { style: "left"; text: "Text Input Options:"; }

            EHeading {
                title: "Text Line Input";
                inherits: "QtQuick.Controls 2.0 TextField";
                stratifyName: "SInput";
                defaultSize: "block";
            }

            SLabel { style: "left"; text: "Input Examples:"; }

            InputExample{}
            ECodeExample { source: "InputExample"; }

        }
    }
}
