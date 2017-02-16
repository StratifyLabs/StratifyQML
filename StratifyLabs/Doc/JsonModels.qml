import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "JsonModels";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {
            EHeading {
                title: "Json Models";
                inherits: "Item";
                stratifyName: "SJsonModel";
            }

            SLabel { style: "left"; text: "Description"; }

        }
    }
}
