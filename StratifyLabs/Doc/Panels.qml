import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "Panels";
    EHeading {
        title: "Panels";
        inherits: "Item";
        stratifyName: "SPanel";
        //specialAttibutes: "Heading";
    }

    ESectionTitle { text: "Description"; }

    SHLine{}

    ESectionTitle { text: "Colors"; }
    PanelExampleColors{}
    ECodeExample { source: "PanelExampleColors"; }

    ESectionTitle { text: "Headings and Footers"; }
    PanelExampleHeadingFooter{}
    ECodeExample { source: "PanelExampleHeadingFooter"; }
}
