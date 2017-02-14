import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Attributes";
    style: "fill";
    SPane {
        style: "block fill";
        SColumn {
            SText { style: "left text-bold"; text: "Introduction"; }
            SText { style: "block"; text: 'StratifyLabs UI allows you to quickly layout and style QML applications. It \
does this by attaching an "SAttributes" object to each item that defines the size and color scheme of each object. \
There are two ways to change an objects attributes: 1) using "style" 2) directly using "attr".'; }
            SText { style: "left text-bold"; text: "'style' Property"; }
            SText { style: "left text-bold"; text: "'attr' Property"; }
        }

    }
}
