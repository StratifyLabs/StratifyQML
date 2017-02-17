import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Tables";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {
            EHeading {
                title: "Tables";
                inherits: "QtQuick.Controls 1.4 TableView";
                stratifyName: "STable";
                defaultSize: "block";
            }

            SLabel { style: "left"; text: "Table Examples:"; }

            TableExample{}
            ECodeExample { source: "TableExample"; }

        }
    }
}
