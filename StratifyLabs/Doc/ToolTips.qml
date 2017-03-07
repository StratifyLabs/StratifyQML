import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
  name: "ToolTips";
  EHeading {
    title: "Tool Tips";
    inherits: "QtQuick.Controls 2.0 ToolTip";
    stratifyName: "SToolTip";
  }

  ESectionTitle { text: "Description"; }

  SHLine{}

  ESectionTitle { text: "Example"; }
  ToolTipExample{}
  ECodeExample { source: "ToolTipExample"; }
}
