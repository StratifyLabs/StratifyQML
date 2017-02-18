import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "Inputs";
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
