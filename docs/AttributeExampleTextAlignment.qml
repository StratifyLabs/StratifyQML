import StratifyLabs.UI 2.0


SRow {
    /* The text alignment styles don't have any meaning unless the
      width is set to something other than it's implicit value. This
      can be done be adding "block" to the styling.
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
}
