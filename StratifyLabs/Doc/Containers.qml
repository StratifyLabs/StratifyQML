import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "Containers";
    EHeading {
        title: "Containers";
        inherits: "Rectangle";
        stratifyName: "SContainer";
        defaultSize: "block";
    }

    ESectionTitle { text: "Description"; }
    SText { style: "block"; text: 'An SContainer provides a padded background \
for a group of S{Objects}. An SContainer may be used on its own or within an SRow or SColumn layout.'; }

    SHLine{}

    ESectionTitle { text: "Background Colors"; }
    ContainerExample{}
    ECodeExample { source: "ContainerExample"; }

    ESectionTitle { text: "Mouse Example"; }
    ContainerExampleMouse{}
    ECodeExample { source: "ContainerExampleMouse"; }
}
