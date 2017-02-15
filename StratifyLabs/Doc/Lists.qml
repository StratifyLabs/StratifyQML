import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Tables";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {
            ElementHeading {
                title: "Buttons";
                inherits: "QtQuick.Controls 2.0 Button";
                stratifyName: "SButton";
                specialAttibutes: "icon";
            }

            SLabel { style: "left"; text: "Button Colors:"; }

            ButtonExampleColors{}
            CodeExample { source: "ButtonExampleColors"; }

            SHLine{}

            SLabel { style: "left"; text: "Button Outlines:"; }

            ButtonExampleOutlineColors{}
            CodeExample { source: "ButtonExampleOutlineColors"; }

            SHLine{}

            SLabel { style: "left"; text: "Icons:"; }

            ButtonExampleIcons{}
            CodeExample { source: "ButtonExampleIcons"; }

            SHLine{}

            SLabel { style: "left"; text: "Button Sizes:"; }

            ButtonExampleSizes{}
            CodeExample { source: "ButtonExampleSizes"; }

            SHLine{}


            SLabel { style: "left"; text: "Naked Buttons:"; }

            ButtonExampleNaked{}
            CodeExample { source: "ButtonExampleNaked"; }

        }
    }
}
