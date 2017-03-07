import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
  name: "Inputs";
  EHeading {
    title: "Text Line Input";
    inherits: "QtQuick.Controls 2.0 TextField";
    stratifyName: "SInput";
    defaultSize: "block";
  }

  ESectionTitle { text: "Description"; }
  EParagraph { text: 'An <i>SInput</i> is used
to for a single line of text input.'; }

  SHLine{}

  ESectionTitle { text: "Example"; }
  InputExample{}
  ECodeButton { source: "InputExample"; }

}
