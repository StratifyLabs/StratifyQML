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
    SText { style: "block"; text: '\
An SAlert is used to alert the user of \
new information. The "warning", "danger", \
and "success" branding colors are useful \
in indicating context of the information.';
        }
    SHLine{}

    ESectionTitle { text: "Colors"; }
    AlertExampleColors{}
    ECodeExample { source: "AlertExampleColors"; }

    ESectionTitle { text: "Options"; }
    SText { style: "block"; text: '\
By default, an SAlert has a dismissible button. \
The button can be disabled by setting "attr.dissmisible" \
to false.';
        }
    AlertExampleOptions{}
    ECodeExample { source: "AlertExampleOptions"; }
}


