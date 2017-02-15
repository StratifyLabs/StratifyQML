import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "AnimationContainers";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {
            ElementHeading {
                title: "Animation Containers";
                inherits: "Item";
                stratifyName: "SAnimationContainer";
                defaultSize: "block";
            }

            SText { style: "left text-bold"; text: "Description"; }
            SText { style: "block"; text: 'An SAnimationContainer is an object that \
can be used to navigate through its resources by setting the "screen" name. An animation \
type (e.g. SAnimationFade or SAnimationHPush) should be included in the container.'; }

            SText { style: "left text-bold"; text: "Simple Example"; }

            AnimationContainerExample{}
            CodeExample { source: "AnimationContainerExample"; }
        }
    }
}
