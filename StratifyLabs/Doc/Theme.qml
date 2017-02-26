import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "Theme";
    ESectionTitle { text: "Introduction"; }
    SText { style: "block"; text: '\
Stratify Labs UI themes are based on the singleton object STheme \
which defines colors, fonts, spacing, and shapes for the application.';
    }
    SText { style: "left text-bold"; text: "Customization"; }
    SText { style: "block"; text: '\
The following example shows how to change the primary and \
secondary brand colors. This code typically goes in the \
main "ApplicationWindow".';
    }
    SWell {
        text: 'Component.onCompleted: {
        STheme.brand_primary = "#244E99";
        STheme.brand_secondary = "#666";
}';
    }

    SText { style: "left text-bold"; text: "Reference"; }
    SText { style: "block"; text: 'See the STheme.qml file for a full list of variables.'; }

    SButton {
        style: "btn-outline-info block";
        text: "View STheme.qml on Github";
        icon: Fa.Icon.external_link;
        onClicked: Qt.openUrlExternally("https://github.com/StratifyLabs/StratifyQML");
    }
}
