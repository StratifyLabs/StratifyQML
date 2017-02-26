import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "Lists";
    EHeading {
        title: "Buttons";
        inherits: "QtQuick.Controls 2.0 Button";
        stratifyName: "SButton";
        specialAttibutes: "icon";
    }

    ESectionTitle { text: "Description"; }

    SHLine{}

    ESectionTitle { text: "Example"; }
    ListExample{}
    ECodeExample { source: "ListExample"; }

    ESectionTitle { text: "ListGroup"; }
    ListExampleListGroup{}
    ECodeExample { source: "ListExampleListGroup"; }

}
