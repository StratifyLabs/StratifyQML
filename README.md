# StratifyQML

Stratify QML is a QML UI framework inspired by Twitter Bootstrap.  The goal is to provide easy-to-use, customizable QML building blocks that follow the Twitter Bootstrap look and feel including responsive elements that look great on any screen.

# Contributors Welcome

Stratify QML is released under the ASL 2.0.  If you are willing to release contributions under this license, please let me know if you would like to help.

# Example

Stratify QML aims to dispense with fine-tuning of anchors and sizes and use a Bootstrap like grid system with rows and columns.  Styling is tweaked using the "style" property similarly to how Bootstrap uses "class" ("class" is a reserved word in QML and cant' be used).

```
SContainer {
  SRow {
    SColumn {
        span: 6;
        SPanel { style: "default"; heading: "Panel"; body: "Default"; }
        SPanel { style: "primary"; heading: "Panel"; body: "Primary"; }
        SPanel { style: "danger"; heading: "Panel"; body: "Danger"; }
        SPanel { style: "success"; heading: "Panel"; body: "Success"; }
        SPanel { style: "info"; heading: "Panel"; body: "Info"; }
        SPanel { style: "warning"; heading: "Panel"; body: "Warning"; }
        SRow {
            SButton{ span: 6; style: "btn-default xs center middle"; text: "Extra Small"; }
            SButton{ span: 6; style: "btn-default sm center middle"; text: "Small"; }
        }
        SRow {
            SButton{ span: 6; style: "btn-default center middle"; text: "Default"; }
            SButton{ span: 6; style: "btn-default lg center middle"; text: "Large"; }
        }
        SRow {
            SButton{ span: 6; style: "lg center middle block"; text: "Block"; }
            SButton{ span: 6; style: "kg center middle"; text: "Default"; }
        }
    }
   }
}
```

![Preview](https://github.com/StratifyLabs/StratifyQML/blob/master/img/preview-20160416.png "Stratify QML Preview")
