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

    ESectionTitle { text: "Description"; }

    SHLine{}

    ESectionTitle { text: "Blocks"; }
    TextExample{}
    ECodeExample { source: "TextExample"; }

    ESectionTitle { text: "Sizes"; }
    TextExampleSizes{}
    ECodeExample { source: "TextExampleSizes"; }

    ESectionTitle { text: "Styles"; }
    TextExampleStyles{}
    ECodeExample { source: "TextExampleStyles"; }
}
