import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Containers";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {
            ElementHeading {
                title: "Containers";
                inherits: "Rectangle";
                stratifyName: "SContainer";
                defaultSize: "block";
            }

            SText { style: "left text-bold"; text: "Description"; }
            SText { style: "block"; text: 'An SContainer provides a padded background \
for a group of S{Objects}. An SContainer may be used on its own or within an SRow or SColumn layout.'; }

            SText { style: "left text-bold"; text: "Background Colors"; }

            ContainerExample{}
            CodeExample { source: "ContainerExample"; }

            SHLine{}

            SText { style: "left text-bold"; text: "Mouse Example"; }

            ContainerExampleMouse{}
            CodeExample { source: "ContainerExampleMouse"; }
        }
    }
}
