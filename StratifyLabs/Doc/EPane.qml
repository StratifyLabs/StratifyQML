import QtQuick 2.7
import QtQuick.Controls 2.1
import StratifyLabs.UI 2.0


SAnimator {
  property string name;
  style: "block fill";
  default property alias data: contents.data;

  id: contentAnimationContainer;

  animation: SAnimationHPush{}

  screen: "content";

  function showCode(source){
    screen = "code";
    code.source = source;

  }

  function showContent() {
    screen = "content";
  }

  resources: [
    SContainer {
      name: "content";
      style: "fill padding-zero";
      SPane {
        clip: false;
        ScrollBar.vertical: ScrollBar {
          visible: !STheme.isScreenSm;
        }
        SContainer {
          SColumn {
            id: contents;
          }
        }
      }
    },

    SContainer {
      name: "code";
      style: "fill padding-zero";
      EViewCode {
        id: code;
      }
    }

  ]
}



