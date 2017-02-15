import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Sliders";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {
            ElementHeading {
                title: "Sliders";
                inherits: "QtQuick.Controls 2.0 Slider";
                stratifyName: "SSlider";
            }

            SLabel { style: "left"; text: "Slider Colors:"; }
            SliderExampleColors{}
            CodeExample { source: "SliderExampleColors"; }

            SHLine{}

            SLabel { style: "left"; text: "Slider Sizes:"; }
            SliderExampleSizes{}
            CodeExample { source: "SliderExampleSizes"; }

        }
    }
}
