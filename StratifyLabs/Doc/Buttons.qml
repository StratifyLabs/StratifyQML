import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "Buttons";
    EHeading {
        title: "Buttons";
        inherits: "QtQuick.Controls 2.0 Button";
        stratifyName: "SButton";
        specialAttibutes: "icon";
    }
    ESectionTitle { text: "Description"; }

    SHLine{}

    ESectionTitle { text: "Colors"; }
    ButtonExampleColors{}
    ECodeExample { source: "ButtonExampleColors"; }

    ESectionTitle { text: "Outlines"; }
    ButtonExampleOutlineColors{}
    ECodeExample { source: "ButtonExampleOutlineColors"; }

    ESectionTitle { text: "Icons"; }
    ButtonExampleIcons{}
    ECodeExample { source: "ButtonExampleIcons"; }

    ESectionTitle { text: "Sizes"; }
    ButtonExampleSizes{}
    ECodeExample { source: "ButtonExampleSizes"; }

    ESectionTitle { text: "Naked"; }
    ButtonExampleNaked{}
    ECodeExample { source: "ButtonExampleNaked"; }

}

