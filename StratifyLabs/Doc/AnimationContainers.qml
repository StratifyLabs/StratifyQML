import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
  name: "AnimationContainers";
  EHeading {
    title: "Animation Containers";
    inherits: "Item";
    stratifyName: "SAnimationContainer";
    defaultSize: "block";
  }

  ESectionTitle { text: "Description"; }
  EParagraph { text: 'An SAnimationContainer is an object that \
can be used to navigate through its resources by setting the "screen" name. An animation \
type (e.g. SAnimationFade or SAnimationHPush) should be included in the container.'; }

  SHLine{}

  ESectionTitle { text: "Simple Example"; }
  AnimationContainerExample{}
  ECodeButton { source: "AnimationContainerExample"; }
}

