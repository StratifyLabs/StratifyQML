import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Introduction";
    style: "fill";
    SPane {
        style: "block fill";
        SColumn {
            SText { style: "left text-bold"; text: "Introduction"; }
            SText { style: "block"; text: 'StratifyLabs UI 2.0 is a QML framework that works, looks, \
and feels much like the twitter bootstrap HTML framework.'; }

        }

    }
}
