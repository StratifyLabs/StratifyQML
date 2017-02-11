import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Buttons";
    style: "fill";
    SPane {
        style: "block fill";

        SColumn {
            ElementHeading {
                title: "Buttons";
                inherits: "QtQuick.Controls 2.0 Button";
                stratifyName: "SButton";
                specialAttibutes: "icon";
            }

            SLabel { style: "left"; text: "Button Colors:"; }

            SRow {
                SButton{ span: 4; style: "btn-primary"; text: "Primary"; }
                SButton{ span: 4; style: "btn-secondary"; text: "Secondary"; }
                SButton{ span: 4; style: "btn-info"; text: "Info"; }
                SButton{ span: 4; style: "btn-success"; text: "Success"; }
                SButton{ span: 4; style: "btn-warning"; text: "Warning"; }
                SButton{ span: 4; style: "btn-danger"; text: "Danger"; }
            }

            SWell {
                text: 'SRow {
                SButton{ span: 4; style: "btn-primary"; text: "Primary"; }
                SButton{ span: 4; style: "btn-secondary"; text: "Secondary"; }
                SButton{ span: 4; style: "btn-info"; text: "Info"; }
                SButton{ span: 4; style: "btn-success"; text: "Success"; }
                SButton{ span: 4; style: "btn-warning"; text: "Warning"; }
                SButton{ span: 4; style: "btn-danger"; text: "Danger"; }
}'
            }

            SHLine{}

            SLabel { style: "left"; text: "Button Outlines:"; }

            SRow {
                SButton{ span: 4; style: "btn-outline-primary"; text: "Primary"; }
                SButton{ span: 4; style: "btn-outline-secondary"; text: "Secondary"; }
                SButton{ span: 4; style: "btn-outline-info"; text: "Info"; }
                SButton{ span: 4; style: "btn-outline-success"; text: "Success"; }
                SButton{ span: 4; style: "btn-outline-warning"; text: "Warning"; }
                SButton{ span: 4; style: "btn-outline-danger"; text: "Danger"; }
            }

            SWell {
                text: 'SRow {
                SButton{ span: 4; style: "btn-outline-primary"; text: "Primary"; }
                SButton{ span: 4; style: "btn-outline-secondary"; text: "Secondary"; }
                SButton{ span: 4; style: "btn-outline-info"; text: "Info"; }
                SButton{ span: 4; style: "btn-outline-success"; text: "Success"; }
                SButton{ span: 4; style: "btn-outline-warning"; text: "Warning"; }
                SButton{ span: 4; style: "btn-outline-danger"; text: "Danger"; }
}'
            }

            SHLine{}

            SLabel { style: "left"; text: "Icons:"; }

            SRow {
                SButton{ span: 4; icon: Fa.Icon.area_chart; text: "Area Chart"; }
                SButton{ span: 4; icon: Fa.Icon.cog; text: "Cog"; }
                SButton{ span: 4; icon: Fa.Icon.refresh; text: "Refresh"; }

                SButton{ span: 4; icon: Fa.Icon.repeat; text: "Repeat"; }
                SButton{ span: 4; icon: Fa.Icon.circle_o_notch; text: "Circle Notch"; }
                SButton{ span: 4; icon: Fa.Icon.spinner; text: "Spinner"; }

                SButton{ span: 4; style: "icon-spin"; icon: Fa.Icon.location_arrow; text: "Spin"; }
                SButton{ span: 4; style: "icon-pulse"; icon: Fa.Icon.spinner; text: "Pulse"; }
                SButton{ span: 4; style: "icon-spin"; icon: Fa.Icon.safari; text: "Spin"; }
            }

            SWell {
                text: 'SRow {
                SButton{ span: 4; icon: Fa.Icon.area_chart; text: "Area Chart"; }
                SButton{ span: 4; icon: Fa.Icon.cog; text: "Cog"; }
                SButton{ span: 4; icon: Fa.Icon.refresh; text: "Refresh"; }

                SButton{ span: 4; icon: Fa.Icon.repeat; text: "Repeat"; }
                SButton{ span: 4; icon: Fa.Icon.circle_o_notch; text: "Circle Notch"; }
                SButton{ span: 4; icon: Fa.Icon.spinner; text: "Spinner"; }

                SButton{ span: 4; style: "icon-spin"; icon: Fa.Icon.location_arrow; text: "Spin"; }
                SButton{ span: 4; style: "icon-pulse"; icon: Fa.Icon.spinner; text: "Pulse"; }
                SButton{ span: 4; style: "icon-spin"; icon: Fa.Icon.safari; text: "Spin"; }
}';
            }

            SHLine{}

            SLabel { style: "left"; text: "Button Sizes:"; }

            SRow {
                SButton{ span: 6; style: "btn-primary btn-xs"; text: "Extra Small"; }
                SButton{ span: 6; style: "btn-primary btn-sm"; text: "Small"; }
                SButton{ span: 6; style: "btn-primary"; text: "Default"; }
                SButton{ span: 6; style: "btn-primary btn-lg"; text: "Large"; }
            }

            SWell {
                text: 'SRow {
                SButton{ span: 6; style: "btn-primary btn-xs"; text: "Extra Small"; }
                SButton{ span: 6; style: "btn-primary btn-sm"; text: "Small"; }
                SButton{ span: 6; style: "btn-primary"; text: "Normal"; }
                SButton{ span: 6; style: "btn-primary btn-lg"; text: "Large"; }
}'
            }

            SHLine{}
        }
    }
}
