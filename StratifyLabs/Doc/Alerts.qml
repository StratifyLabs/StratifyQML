import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "Alerts";
    EHeading {
        title: "Alerts";
        inherits: "QtQuick.Controls 2.0 Rectangle";
        stratifyName: "SAlert";
        defaultSize: "block";
    }

    ESectionTitle { text: "Description"; }

    SHLine{}

    ESectionTitle { text: "Colors"; }
    AlertExampleColors{}
    ECodeExample { source: "AlertExampleColors"; }

    ESectionTitle { text: "Options"; }
    AlertExampleOptions{}
    ECodeExample { source: "AlertExampleOptions"; }
}


