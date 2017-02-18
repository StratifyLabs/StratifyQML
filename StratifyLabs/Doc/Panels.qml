import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "Panels";
    EHeading {
        title: "Panels";
        inherits: "Item";
        stratifyName: "SPanel";
        //specialAttibutes: "EHeading";
    }

    SLabel { style: "left"; text: "Panel Colors:"; }


    PanelExampleColors{}
    ECodeExample { source: "PanelExampleColors"; }

    SHLine {}

    SLabel { style: "left"; text: "Panel EHeadings and Footers:"; }

    PanelExampleHeadingFooter{}
    ECodeExample { source: "PanelExampleHeadingFooter"; }
}
