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

    ESectionTitle { text: "Description"; }

    SHLine{}

    ESectionTitle { text: "Example"; }
    InputExample{}
    ECodeExample { source: "InputExample"; }

}
