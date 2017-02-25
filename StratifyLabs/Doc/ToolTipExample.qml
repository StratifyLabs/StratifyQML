import StratifyLabs.UI 2.0

SRow {
    SButton {
        span: 4;
        style: "btn-primary";
        text: "Button with ToolTip";
        SToolTip {
            text: "Button";
        }
    }
    SCheckBox {
        span: 4;
        text: "Check Box with ToolTip";
        SToolTip {
            text: "Check Box";
        }
    }
    SRadioButton {
        span: 4;
        text: "Radio Button with ToolTip";
        SToolTip {
            text: "Radio Button";
        }
    }
}
