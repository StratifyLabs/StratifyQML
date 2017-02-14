import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Panels";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {
            ElementHeading {
                title: "Panels";
                inherits: "Item";
                stratifyName: "SPanel";
                //specialAttibutes: "heading";
            }

            SLabel { style: "left"; text: "Panel Colors:"; }


            PanelExampleColors{}
            CodeExample { source: "PanelExampleColors"; }

            SHLine {}

            SLabel { style: "left"; text: "Panel Headings and Footers:"; }

            PanelExampleHeadingFooter{}
            CodeExample { source: "PanelExampleHeadingFooter"; }

        }
    }
}
