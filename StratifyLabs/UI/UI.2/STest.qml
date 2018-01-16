/*
Copyright 2016 Tyler Gilbert

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/


import QtQuick 2.6
import QtQuick.Controls 2.1
import "../STestListText.js" as List;
import StratifyLabs.UI 2.0


Item {
    id: top;

    anchors.fill: parent;

    SDrawer {
        id: drawer
        width: 250;
        height: parent.height;

        style: "primary";


        property string menuStyle: "left lg primary block text-left";

        SContainer {
            SColumn {
                SText { style: "left text-primary"; text: "Menu"; }
                SHLine{ attr.paddingVertical: 0; }
                SRadioButton { symbol: Fa.Icon.chevron_right; style: "left lg text-primary"; text: "Alerts"; onPressed: { tests.screen = text; drawer.close(); } }
                SRadioButton { symbol: Fa.Icon.chevron_right; style: "left lg text-primary"; text: "Panels"; onPressed: { tests.screen = text; drawer.close(); } }
                SRadioButton { symbol: Fa.Icon.chevron_right; style: "left lg text-primary"; text: "Wells"; onPressed: { tests.screen = text; drawer.close(); } }
                SHLine{ attr.paddingVertical: 0; }
                SRadioButton { symbol: Fa.Icon.chevron_right; style: "left lg text-primary"; text: "Buttons"; onPressed: { tests.screen = text; drawer.close(); } }
                SRadioButton { symbol: Fa.Icon.chevron_right; style: "left lg text-primary"; text: "Labels"; onPressed: { tests.screen = text; drawer.close(); } }
                SRadioButton { symbol: Fa.Icon.chevron_right; style: "left lg text-primary"; text: "Input"; onPressed: { tests.screen = text; drawer.close(); } }
                SHLine{ attr.paddingVertical: 0; }
                SRadioButton { symbol: Fa.Icon.chevron_right; style: "left lg text-primary"; text: "Lists"; onPressed: { tests.screen = text; drawer.close(); } }
                SRadioButton { symbol: Fa.Icon.chevron_right; style: "left lg text-primary"; text: "Tables"; onPressed: { tests.screen = text; drawer.close(); } }
                SRadioButton { symbol: Fa.Icon.chevron_right; style: "left lg text-primary"; text: "ToolTips"; onPressed: { tests.screen = text; drawer.close(); } }
                SRadioButton { symbol: Fa.Icon.chevron_right; style: "left lg text-primary"; text: "Progress"; onPressed: { tests.screen = text; drawer.close(); } }
            }
        }
    }


    SModal {
        id: aboutModal;
        title: "About";
        standardButtons: 0;
        SColumn {
            SText {
                style: "block";
                text: "STheme 2.0 is a QML framework that works, looks, and feels much like the twitter bootstrap HTML framework";
            }
        }
    }



    SColumn {
        style: "block fill";
        SContainer {
            color: STheme.brand_danger;

            SRow {
                SButton {
                    span: 1;
                    style: "left";
                    symbol: Fa.Icon.bars;
                    onClicked: drawer.open();
                }
                SButton {
                    span: 1;
                    style: "right";
                    symbol: Fa.Icon.info_circle;
                    onClicked: aboutModal.open();
                }
            }

        }

        SAnimationContainer {
            id: tests;
            style: "block fill";

            SAnimationFade{ id: animation; }
            screen: "Alerts";

            Component.onCompleted: {
                showScreen(current);
            }

            resources: [
                SContainer {
                    name: "Alerts";
                    style: "block fill";
                    SRow {
                        style: "block fill";
                        SAlert { span: 6; style: "fill alert-success"; text: "<b>Alert!</b> Success"; }
                        SAlert { span: 6; style: "fill alert-info"; text: "<b>Alert!</b> Info"; }
                        SAlert { span: 6; style: "alert-warning"; text: "<b>Alert!</b> Warning"; }
                        SAlert { span: 6; style: "alert-danger"; text: "<b>Alert!</b> Danger"; }
                        SAlert { span: 6; style: "alert-info text-center"; text: "<b>Alert!</b> Center"; }
                        SAlert { span: 6; style: "alert-success text-right"; text: "<b>Alert!</b> Right (fix me)"; }
                    }
                },

                SContainer {
                    name: "Buttons";
                    style: "fill";
                    SPane {
                        style: "block fill";


                        SColumn {
                            SLabel { style: "left fill"; text: "Button Colors:"; }

                            SRow {
                                SButton{ span: 4; style: "btn-primary center"; text: "Primary"; }
                                SButton{ span: 4; style: "btn-outline-primary center"; text: "Outline Primary"; }
                                SButton{ span: 4; style: "btn-secondary center"; text: "Secondary"; }
                                SButton{ span: 4; style: "btn-outline-secondary center"; text: "Outline Secondary"; }
                                SButton{ span: 4; style: "btn-info center"; text: "Info"; }
                                SButton{ span: 4; style: "btn-outline-info center"; text: "Outline Info"; }
                                SButton{ span: 4; style: "btn-success center"; text: "Success"; }
                                SButton{ span: 4; style: "btn-outline-success center"; text: "Outline Success"; }
                                SButton{ span: 4; style: "btn-warning center"; text: "Warning"; }
                                SButton{ span: 4; style: "btn-outline-warning center"; text: "Outline Warning"; }
                                SButton{ span: 4; style: "btn-danger center"; text: "Danger"; }
                                SButton{ span: 4; style: "btn-outline-danger center"; text: "Outline Danger"; }
                            }

                            SHLine{}

                            SLabel { style: "left"; text: "Button Sizes:"; }

                            SRow {
                                SButton{ span: 6; style: "btn-default btn-xs"; text: "Extra Small"; }
                                SButton{ span: 6; style: "btn-default btn-sm"; text: "Small"; }
                                SButton{ span: 6; style: "btn-default"; text: "Default"; }
                                SButton{ span: 6; style: "btn-default btn-lg"; text: "Large"; }
                            }

                            SHLine{}

                            SLabel { style: "left"; text: "Button Icons:"; }

                            SRow {
                                SButton{ span: 4; style: "btn-block btn-primary btn-lg center icon-spin"; symbol: Fa.Icon.refresh; text: "Refresh"; }
                                SButton{ span: 4; style: "btn-block btn-primary btn-lg center icon-spin"; symbol: Fa.Icon.cog; text: "Working"; }
                                SButton{ span: 4; style: "btn-block btn-primary btn-lg center icon-pulse"; symbol: Fa.Icon.refresh; text: "Pulse"; }

                                SButton{ span: 4; style: "btn-primary btn-lg center icon-spin"; symbol: Fa.Icon.spinner; text: "Refresh"; }
                                SButton{ span: 4; style: "btn-primary btn-lg center icon-spin"; symbol: Fa.Icon.circle_o_notch; text: "Working"; }
                                SButton{ span: 4; style: "btn-primary btn-lg center icon-pulse"; symbol: Fa.Icon.spinner; text: "Pulse";  }

                                SButton{ span: 4; style: "btn-lg center icon-spin"; symbol: Fa.Icon.location_arrow; text: "Naked"; }
                                SButton{ span: 4; style: "btn-lg center icon-pulse"; symbol: Fa.Icon.repeat; text: "Naked"; }
                                SButton{ span: 4; style: "btn-lg center icon-spin"; symbol: Fa.Icon.safari; text: "Naked"; }
                            }


                        }
                    }
                },

                SContainer {
                    name: "Labels";
                    SColumn {

                        SPanel {
                            heading: "Labels";
                            style: "block";
                            SColumn {
                                SText {
                                    style: "block";
                                    text: "Labels look much like buttons but when don't change colors when hovered.  They do not support onClicked signal handlers.";
                                }
                            }
                        }

                        SLabel{ style: "left"; text: "Labels:"; }

                        SRow {
                            SLabel{ span: 4; style: "label-default"; text: "Default"; }
                            SLabel{ span: 4; style: "label-primary"; text: "Primary"; }
                            SLabel{ span: 4; style: "label-info"; text: "Info"; }
                            SLabel{ span: 4; style: "label-success"; text: "Success"; }
                            SLabel{ span: 4; style: "label-warning"; text: "Warning"; }
                            SLabel{ span: 4; style: "label-danger"; text: "Danger"; }
                        }

                        SHLine{}

                        SLabel{ style: "left"; text: "Label Sizes and Positions:"; }

                        SRow {
                            SLabel{ span: 4; style: "label-default label-sm center"; text: "Small"; }
                            SLabel{ span: 4; style: "label-default center"; text: "Medium"; }
                            SLabel{ span: 4; style: "label-default label-lg center"; text: "Large"; }
                            SLabel{ span: 4; style: "label-default left"; text: "Left"; }
                            SLabel{ span: 4; style: "label-default center"; text: "Center"; }
                            SLabel{ span: 4; style: "label-default right"; text: "Right"; }
                            SLabel{ span: 4; style: "label-default block text-right"; text: "Block Text Right"; }
                            SLabel{ span: 4; style: "label-default block text-center"; text: "Block Text Center"; }
                            SLabel{ span: 4; style: "label-default block text-left"; text: "Block Text Left"; }
                        }

                    }
                },

                SContainer {
                    name: "Input";
                    style: "block fill";
                    SColumn {
                        style: "block fill";

                        SRow {
                            SCheckbox{ span: 6; style: "center"; text: "Checkbox 1"; }
                            SCheckbox{ span: 6; style: "center"; text: "Checkbox 2"; }

                            SRadioButton { span: 6; style: "center"; text: "RadioButton 1"; }
                            SRadioButton { span: 6; style: "center"; text: "RadioButton 2"; }
                        }


                        SRow {
                            SLabel { span: 3; style: "block text-left hide-sm"; text: "Select"; }
                            SDropdown {
                                style: "block";
                                span: 9;
                                model: ["First", "Second", "Third", "Fourth"];
                            }
                            SLabel { span: 3; style: "block text-left hide-sm"; text: "Select"; }
                            SDropdown {
                                style: "block";
                                span: 9;
                                model: ["First"];
                            }
                            SLabel { span: 3; style: "block text-left hide-sm"; text: "Select"; }
                            SDropdown {
                                style: "block";
                                span: 9;
                                model: ["First", "Second"];
                            }
                        }

                        SRow {
                            SLabel { span: 3; style: "block text-left hide-sm"; text: "Username"; }
                            SInput { span: 9; style: "block"; text: "StratifyLabs"; }
                        }

                        SRow {
                            SLabel { span: 3; style: "block text-left"; text: "Password"; }
                            SPassword { span: 9; text: "Password"; }
                        }

                        SInput { placeholder: "username"; }
                        SPassword { placeholder: "password"; }

                        STextBox {
                            style: "block fill";
                            implicitHeight: 100;
                        }

                    }
                },

                SContainer {
                    name: "Lists";
                    SJsonModel {
                        id: jsonModel;
                        json: List.data;
                    }
                    SRow {
                        SListgroup {
                            span: 4;
                            style: "left";
                            model: jsonModel;
                        }

                        SListgroup {
                            span: 4;
                            style: "center";
                            model: jsonModel;
                        }

                        SListgroup {
                            span: 4;
                            style: "right";
                            model: jsonModel;
                        }

                        SListgroup {
                            span: 4;
                            style: "block";
                            model: jsonModel;
                        }

                        SListgroup {
                            span: 4;
                            style: "block";
                            model: jsonModel;
                        }

                        SListgroup {
                            span: 4;
                            style: "block";
                            model: jsonModel;
                        }
                    }

                },
                SContainer {
                    name: "Panels";

                    SRow {
                        SPanel { span: 4; style: "panel-primary"; heading: "Primary"; SText { text: "Primary Panel"; } }
                        SPanel { span: 4; style: "panel-default"; heading: "Default"; SText { text: "Default Panel"; } }
                        SPanel { span: 4; style: "panel-warning"; heading: "Warning"; SText { text: "Warning Panel"; } }
                        SPanel { span: 4; style: "panel-success"; heading: "Success"; SText { text: "Success Panel"; } }
                        SPanel { span: 4; style: "panel-danger"; heading: "Danger"; SText { text: "Danger Panel"; } }
                        SPanel { span: 4; style: "panel-info"; heading: "Info"; SText { text: "Info Panel"; }}
                        SPanel { span: 4; style: "panel-default";
                            SColumn {
                                SText { style: "block"; text: "Panel with no heading and no footer"; }
                            }
                        }
                        SPanel { span: 4; style: "panel-default";
                            footer: "Panel Footer";
                            SColumn {
                                SText { style: "block"; text: "Panel with footer and no heading"; }
                            }
                        }
                        SPanel { span: 4; style: "panel-default";
                            heading: "Panel Heading";
                            footer: "Panel Footer";
                            SColumn {
                                SText { style: "block"; text: "Panel with heading and footer"; }
                            }
                        }
                    }


                },

                SContainer {
                    name: "Wells";
                    SRow {
                        SWell { span: 6; style: "well"; text: "Default Well"; }
                        SWell { span: 6; style: "well-sm"; text: "Small Well"; }
                        SWell { span: 6; style: "well-lg";  text: "Large Well"; }
                        SWell { span: 6; style: "well-xs"; text: "Extra Small Well"; }
                    }

                },

                SContainer {
                    style: "fill";
                    name: "Tables";

                    SColumn {
                        style: "fill";


                        ListModel {
                            id: libraryModel;
                            ListElement {
                                title: "A Masterpiece"
                                author: "Gabriel"
                            }
                            ListElement {
                                title: "Brilliance"
                                author: "Jens"
                            }
                            ListElement {
                                title: "Outstanding"
                                author: "Frederik"
                            }
                            ListElement {
                                title: "A Masterpiece"
                                author: "Gabriel"
                            }
                        }


                        STable{
                            model: libraryModel;
                            style: "block table-striped";

                            STableColumn {
                                span: 6;
                                role: "title";
                                title: "Title";
                            }

                            STableColumn {
                                span: 6;
                                role: "author"
                                title: "Author"
                            }
                        }


                        STable{
                            model: libraryModel;
                            style: "block table-condensed";

                            STableColumn {
                                span: 6;
                                role: "title";
                                title: "Title";
                            }

                            STableColumn {
                                span: 6;
                                role: "author"
                                title: "Author"
                            }
                        }

                        STable{
                            model: libraryModel;
                            style: "block table-bordered";

                            STableColumn {
                                span: 6;
                                role: "title";
                                title: "Title";
                            }

                            STableColumn {
                                span: 6;
                                role: "author"
                                title: "Author"
                            }
                        }

                        STable{
                            model: libraryModel;
                            style: "fill block table-hover";

                            STableColumn {
                                span: 6;
                                role: "title";
                                title: "Title";
                            }

                            STableColumn {
                                span: 6;
                                role: "author"
                                title: "Author"
                            }
                        }

                    }
                },

                SContainer {
                    name: "ToolTips";
                    SRow {
                        SButton {
                            text: "Tooltip";
                            style: "btn-default";
                            span: 2;
                            SToolTip {
                                text: "This is a tooltip";
                            }
                        }
                    }
                },

                SContainer {
                    name: "Progress";
                    SColumn {
                        SProgressBar {
                            style: "progress-bar-primary";
                            value: 0.75;
                        }
                        SProgressBar {
                            style: "progress-bar-warning condensed";
                            value: 0.25;
                        }
                        SProgressBar {
                            style: "progress-bar-danger";
                            value: 0.5;
                        }
                        SProgressBar {
                            style: "progress-bar-success";
                            value: 1.0;
                        }

                        SSlider {
                            style: "progress-bar-success";
                            value: 1.0;
                        }

                        SProgressCircle {
                            //style: "primary";
                            value: 0.25;
                            SColumn {
                                style: "fill";
                                SIcon {
                                    style: "h3";
                                    symbol: Fa.Icon.cloud;
                                }
                            }
                        }
                    }
                }

            ]
        }
    }
}
