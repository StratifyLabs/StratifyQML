import QtQuick 2.0
import StratifyLabs.UI 2.0

SContainer {
    id: root;
    property alias label: label.text;
    property alias icon: icon.icon;

    SRow {
        SText { id: label; span: 10; style: "left text-on-secondary text-bold"; }
        SIcon { id: icon; span: 2; style: "right text-on-secondary"; }
    }
}
