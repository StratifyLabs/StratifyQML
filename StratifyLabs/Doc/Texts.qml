import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "Texts";
    EHeading {
        title: "Buttons";
        inherits: "QtQuick.Controls 2.0 Button";
        stratifyName: "SButton";
        specialAttibutes: "icon";
    }

    SLabel { style: "left"; text: "Text Blocks:"; }

    TextExample{}
    ECodeExample { source: "TextExample"; }

    SLabel { style: "left"; text: "Text Sizes:"; }

    TextExampleSizes{}
    ECodeExample { source: "TextExampleSizes"; }

    SLabel { style: "left"; text: "Text Styles:"; }

    TextExampleStyles{}
    ECodeExample { source: "TextExampleStyles"; }
}
