import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "Tables";
    EHeading {
        title: "Tables";
        inherits: "QtQuick.Controls 1.4 TableView";
        stratifyName: "STable";
        defaultSize: "block";
    }

    SLabel { style: "left"; text: "Simple Table Example:"; }

    TableExample{}
    ECodeExample { source: "TableExample"; }

    SLabel { style: "left"; text: "Table Options:"; }


    TableExampleOptions{}
    ECodeExample { source: "TableExampleOptions"; }

}
