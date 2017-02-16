import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Buttons";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {
            EHeading {
                title: "Buttons";
                inherits: "QtQuick.Controls 2.0 Button";
                stratifyName: "SButton";
                specialAttibutes: "icon";
            }

            SLabel { style: "left"; text: "Button Colors:"; }

            ButtonExampleColors{}
            ECodeExample { source: "ButtonExampleColors"; }

            SHLine{}

            SLabel { style: "left"; text: "Button Outlines:"; }

            ButtonExampleOutlineColors{}
            ECodeExample { source: "ButtonExampleOutlineColors"; }

            SHLine{}

            SLabel { style: "left"; text: "Icons:"; }

            ButtonExampleIcons{}
            ECodeExample { source: "ButtonExampleIcons"; }

            SHLine{}

            SLabel { style: "left"; text: "Button Sizes:"; }

            ButtonExampleSizes{}
            ECodeExample { source: "ButtonExampleSizes"; }

            SHLine{}


            SLabel { style: "left"; text: "Naked Buttons:"; }

            ButtonExampleNaked{}
            ECodeExample { source: "ButtonExampleNaked"; }

        }
    }
}
