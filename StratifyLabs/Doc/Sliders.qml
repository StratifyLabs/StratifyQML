import QtQuick 2.6
import StratifyLabs.UI 2.0

EPane {
    name: "Sliders";

    EHeading {
        title: "Sliders";
        inherits: "QtQuick.Controls 2.0 Slider";
        stratifyName: "SSlider";
    }

    SLabel { style: "left"; text: "Slider Colors:"; }
    SliderExampleColors{}
    ECodeExample { source: "SliderExampleColors"; }

    SHLine{}

    SLabel { style: "left"; text: "Slider Sizes:"; }
    SliderExampleSizes{}
    ECodeExample { source: "SliderExampleSizes"; }

}
