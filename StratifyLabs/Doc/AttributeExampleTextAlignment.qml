import StratifyLabs.UI 2.0


SRow {
    /* The text alignment styles don't have any meaning unless the
      dimensions are set to something other than it's implicit value. This
      can be done be adding "block" and/or "fill" to the styling.
      */
    SLabel {
        span: 4;
        style: "label-info block text-right";
        text: "Block Text Right";
    }
    SLabel {
        span: 4;
        style: "label-info block text-center";
        text: "Block Text Center";
    }
    SLabel {
        span: 4;
        style: "label-info block text-left";
        text: "Block Text Left";
    }
    SContainer {
        implicitHeight: 300;
        style: "padding-zero";
        SColumn {
            style: "fill";
            SLabel {
                style: "label-info fill text-top";
                text: "Fill Text Top";
            }
            SLabel {
                style: "label-info fill text-middle";
                text: "Fill Text MIddle";
            }
            SLabel {
                style: "label-info fill text-bottom";
                text: "Fill Text Bottom";
            }
        }
    }
}
