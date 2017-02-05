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
import QtQuick.Controls 1.4
import Qt.labs.folderlistmodel 2.1
import "Fa-4.5.0.js" as Fa
import "STestListText.js" as List;
import "."


SItem {
    id: top;

    style: "fill";



    SColumn {

        SContainer {
            style: "block";
            properties.backgroundColor: StratifyUI.brand_danger;

            SRow {
                SRadioButton { span: 3; style: "text-hide-sm center"; text: "AlertTest"; onPressed: tests.screen = text; }
                SRadioButton { span: 3; style: "text-hide-sm center"; text: "ButtonTest"; onPressed: tests.screen = text; }
                SRadioButton { span: 3; style: "text-hide-sm center"; text: "LabelTest"; onPressed: tests.screen = text; }
                SRadioButton { span: 3; style: "text-hide-sm center"; text: "InputTest"; onPressed: tests.screen = text; }
            }

        }

        SAnimationContainer {
            id: tests;
            style: "block fill";

            SAnimationHPush{ id: animation; }
            screen: "AlertTest";

            Component.onCompleted: {
                showScreen(current);
            }

            resources: [
                SContainer {
                    name: "AlertTest";

                    SRow {
                        SAlert { span: 6; style: "alert-success"; text: "<b>Alert!</b> Success"; }
                        SAlert { span: 6; style: "alert-info"; text: "<b>Alert!</b> Info"; }
                        SAlert { span: 6; style: "alert-warning"; text: "<b>Alert!</b> Warning"; }
                        SAlert { span: 6; style: "alert-danger"; text: "<b>Alert!</b> Danger"; }
                        SAlert { span: 6; style: "alert-info text-center"; text: "<b>Alert!</b> Center"; }
                        SAlert { span: 6; style: "alert-success text-right"; text: "<b>Alert!</b> Right (fix me)"; }
                        SWell { span: 6; style: "well-lg"; text: "Large Well"; }
                        SWell { span: 6; style: "well-sm"; text: "Small Well"; }
                        SWell { span: 6; style: "well-default"; text: "Well"; }
                    }

                    //SDropdown{ style: "btn-default"; text: "Hello"; }
                },

                SContainer {
                    name: "ButtonTest";
                    SColumn {
                        SLabel { style: "left"; text: "Button Colors:"; }

                        SRow {
                            SButton{ span: 6; style: "btn-default center"; text: "Default"; }
                            SButton{ span: 6; style: "btn-primary center"; text: "Primary"; }
                            SButton{ span: 6; style: "btn-info center"; text: "Info"; }
                            SButton{ span: 6; style: "btn-success center"; text: "Success"; }
                            SButton{ span: 6; style: "btn-warning center"; text: "Warning"; }
                            SButton{ span: 6; style: "btn-danger center"; text: "Danger"; }
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
                            SButton{ span: 4; style: "btn-primary btn-lg center fa-spin"; icon: Fa.Icon.refresh; text: "Refresh"; }
                            SButton{ span: 4; style: "btn-primary btn-lg center fa-spin"; icon: Fa.Icon.cog; text: "Working"; }
                            SButton{ span: 4; style: "btn-primary btn-lg center fa-pulse"; icon: Fa.Icon.refresh; text: "Pulse"; }
                        }

                        SRow {
                            SButton{ span: 4; style: "btn-primary btn-lg center fa-spin"; icon: Fa.Icon.spinner; text: "Refresh"; spin: true; }
                            SButton{ span: 4; style: "btn-primary btn-lg center fa-spin"; icon: Fa.Icon.circle_o_notch; text: "Working"; spin: true; }
                            SButton{ span: 4; style: "btn-primary btn-lg center fa-pulse"; icon: Fa.Icon.spinner; text: "Pulse";  pulse: true; }
                        }

                        SRow {
                            SButton{ span: 4; style: "btn-lg center fa-spin"; icon: Fa.Icon.location_arrow; text: "Naked"; }
                            SButton{ span: 4; style: "btn-lg center fa-pulse"; icon: Fa.Icon.repeat; text: "Naked"; }
                            SButton{ span: 4; style: "btn-lg center fa-spin"; icon: Fa.Icon.safari; text: "Naked"; }
                        }


                    }
                },

                SContainer {
                    name: "LabelTest";
                    SColumn {

                        SPanel {
                            heading: "Labels";
                            body: "Labels look much like buttons but when don't change colors when hovered.  They do not support onClicked signal handlers."
                        }

                        SHLine{}


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
                    name: "InputTest";
                    SColumn {
                        SRow {
                            SCheckbox{ span: 4; style: "left"; text: "Checkbox 1"; }
                            SCheckbox{ span: 4; style: "left"; text: "Checkbox 2"; }
                            SCheckbox{ span: 4; style: "left"; text: "Checkbox 3"; }
                        }

                        SRow {
                            SRadioButton { span: 4; style: "left"; text: "RadioButton 1"; }
                            SRadioButton { span: 4; style: "left"; text: "RadioButton 2"; }
                            SRadioButton { span: 4; style: "left"; text: "RadioButton 3"; }
                        }

                        SRow {
                            SLabel { span: 3; style: "block text-left"; text: "Username"; }
                            SInput { span: 9; text: "StratifyLabs"; }
                        }

                        SRow {
                            SLabel { span: 3; style: "block text-left"; text: "Password"; }
                            SPassword { span: 9; text: "Password"; }
                        }

                        SRow {
                            SIcon { style: "left"; span: 1; icon: Fa.Icon.user; }
                            SInput { span: 11; text: "StratifyLabs"; }
                        }

                        SRow {
                            SIcon { id: password; style: "left"; span: 1; icon: Fa.Icon.lock; }
                            SPassword { span: 11; text: "Password"; }
                        }

                        SInput { placeholder: "username"; }
                        SPassword { placeholder: "password"; }

                        SRow {
                            STextBox {
                                span: 12; implicitHeight: 200;
                            }
                        }

                        /*
                        SListgroup {
                            name: "List";
                            SJsonListModel {
                                id: jsonModel;
                                json: List.data;
                            }

                            model: jsonModel.model;
                        }
                        */
                    }
                }

            ]
        }
    }
}
