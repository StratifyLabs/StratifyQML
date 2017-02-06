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
import "../STestListText.js" as List;
import StratifyLabs.UI 1.0


SItem {
    id: top;

    style: "fill";

    SColumn {
        style: "fill";
        SContainer {
            background: theme.brand_danger;
            SRow {
                SRadioButtonControl { id: radioButtonControl;
                    onActiveChanged: {
                        if( tests != null ){
                            tests.screen = active.text;
                        }
                    }
                }
                SRadioButton { style: "text-hide-sm center"; control: radioButtonControl; text: "CarouselTest"; }
                SRadioButton { style: "text-hide-sm center"; control: radioButtonControl; text: "PanelTest"; }
                SRadioButton { style: "text-hide-sm center"; control: radioButtonControl; text: "AlertTest"; }
                SRadioButton { style: "text-hide-sm center"; control: radioButtonControl; text: "ButtonTest"; }
                SRadioButton { style: "text-hide-sm center"; control: radioButtonControl; text: "LabelTest"; }
                SRadioButton { style: "text-hide-sm center"; control: radioButtonControl; text: "InputTest"; }
                SRadioButton { style: "text-hide-sm center"; checked:true; control: radioButtonControl; text: "TableTest"; }

            }

        }


        SAnimationContainer {
            id: tests;
            style: "fill";

            SAnimationHPush{ id: animation; }
            screen: "CarouselTest";

            Component.onCompleted: {
                showScreen(current);
            }

            resources: [
                SContainer {
                    name: "CarouselTest";

                    SCarousel{
                        x:10;
                        width: parent.width;
                        height: 300;
                        interval: 1000
                        model: ListModel {
                            id: listModel2;
                            Component.onCompleted: {
                                var xhr = new XMLHttpRequest();
                                var source = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY"
                                var jsonResponse;
                                xhr.open("GET", source);
                                xhr.onreadystatechange = function() {
                                    if (xhr.readyState === XMLHttpRequest.DONE){
                                        jsonResponse = xhr.responseText;
                                        var jsonObj = JSON.parse(jsonResponse);

                                        for (var i in jsonObj["photos"]) {
                                            var item = jsonObj["photos"][i];
                                            // model ROLE "source" is to display the image,
                                            // model ROLE "caption" is to show the text
                                            listModel2.append({"source" : item["img_src"], "caption" : item["id"]});
                                        }
                                    }
                                }
                                xhr.send();
                            }

                        }
                    }

                },

                SContainer {
                    name: "PanelTest";


                    SColumn {
                        SPanel { style: "default"; heading: "Panel";
                            SRow {
                                SButton { text: "Default"; style: "btn-default"; }
                                SButton { text: "Panel"; style: "btn-default"; }
                            }
                        }
                        SPanel { style: "panel-primary"; heading: "Panel"; body: "Primary"; }
                        SPanel { style: "panel-danger"; heading: "Panel"; body: "Danger"; }
                        SPanel { style: "panel-success"; heading: "Panel"; body: "Success"; }
                        SPanel { style: "panel-info"; heading: "Panel"; body: "Info"; }
                        SPanel { style: "panel-warning"; heading: "Panel"; body: "Warning"; }

                    }
                },

                SContainer {
                    name: "AlertTest";

                    SColumn {
                        SAlert { style: "alert-success"; text: "<b>Alert!</b> Success"; }
                        SAlert { style: "alert-info"; text: "<b>Alert!</b> Info"; }
                        SAlert { style: "alert-warning"; text: "<b>Alert!</b> Warning"; }
                        SAlert { style: "alert-danger"; text: "<b>Alert!</b> Danger"; }
                        SWell { style: "well-lg"; text: "Large Well"; }
                        SWell { style: "well-sm"; text: "Small Well"; }
                        SWell { style: "well-default"; text: "Well"; }
                    }

                    //SDropdown{ style: "btn-default"; text: "Hello"; }
                },

                SContainer {
                    name: "ButtonTest";
                    SColumn {
                        SRow { SText{ style: "left"; text: "Buttons:"; span:12; } }

                        SRow {
                            SButton{ span: 4; style: "btn-default center"; icon: Fa.Icon.check; text: "Default"; }
                            SButton{ span: 4; style: "btn-primary center"; icon: Fa.Icon.times; text: "Primary"; }
                            SButton{ span: 4; style: "btn-info center"; icon: Fa.Icon.lock; text: "Info"; }
                        }

                        SRow {
                            SButton{ span: 4; style: "btn-success center"; text: "Success"; }
                            SButton{ span: 4; style: "btn-warning center"; text: "Warning"; }
                            SButton{ span: 4; style: "btn-danger center"; text: "Danger"; }
                        }

                        SHLine{}

                        SRow { SText{ style: "center"; text: "Button Sizes:"; span:12; } }

                        SRow {
                            SButton{ span: 6; style: "btn-default btn-xs center middle"; text: "Extra Small"; }
                            SButton{ span: 6; style: "btn-default btn-sm center middle"; text: "Small";
                                SPopover{ content: "Default Button Middle"; style: "top"; }
                            }
                        }


                        SRow {
                            SButton{ span: 6; style: "btn-default center middle"; text: "Default";
                                STooltip{ text: "Default Button Middle"; style: "top"; }
                            }
                            SButton{ span: 6; style: "btn-default btn-lg center middle"; text: "Large";
                                STooltip{ text: "Default Large Button Middle"; style: "top"; }
                            }
                        }




                        SHLine{}

                        SRow { SText{ style: "center"; text: "Button Icons:"; span:12; } }

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
                            body: "Labels look much like buttons but when don't change colors when hovered.  They do support onClicked signal handlers."
                        }

                        SRow { SText{ style: "center"; text: "Labels:"; span:12; } }

                        SRow {
                            SLabel{ id: labelDefault; span: 4; style: "label-default center sm middle"; text: "Default";
                                tooltip: STooltip { target: labelDefault; parent: top; text: "Default Center Small"; style: "bottom"; }
                            }
                            SLabel{ span: 4; style: "label-primary center xs middle"; text: "Primary"; }
                            SLabel{ span: 4; style: "label-info center lg middle"; text: "Info"; }
                        }

                        SRow {
                            SLabel{ id: labelSuccess; span: 4; style: "label-success center"; text: "Success";
                                tooltip: STooltip { target: labelSuccess.contents; parent: top; text: "Label Success Center"; style: "right"; }
                            }
                            SLabel{ id: warningLabel; span: 4; style: "label-warning center"; text: "Warning";
                                tooltip: STooltip { target: warningLabel.contents; parent: top; text: "Label Warning Center"; style: "left"; }

                            }
                            SLabel{ span: 4; style: "label-danger center"; text: "Danger"; }
                        }

                        SHLine{}

                        SRow { SText{ style: "right"; text: "Label Sizes:"; span:12; } }


                    }
                },

                SContainer {
                    name: "InputTest";
                    SColumn {
                        SRow {
                            SCheckbox{ text: "Checkbox"; }
                            SCheckbox{ id: checkTool; text: "Checkbox w/ Tooltip";
                                tooltip: STooltip { target: checkTool; parent: top; text: "Checkbox tooltip"; style: "bottom"; }
                            }
                        }

                        SRow {
                            SText { span: 2; text: "User"; }
                            SInput { span: 10; text: "StratifyLabs"; }
                        }

                        SRow {
                            SText { span: 2; text: "Pass"; }
                            SPassword { span: 10; text: ""; }
                        }

                        SRow {
                            SText { span: 2; text: Fa.Icon.user; style: "fa"; }
                            SInput { span: 10; text: "StratifyLabs"; }
                        }

                        SRow {
                            SIcon { id: password; span: 2; text: Fa.Icon.lock;
                                tooltip: STooltip{ target: password.contents; parent: top; text: "Password"; style: "left"; }
                            }
                            SPassword { span: 10; text: ""; }
                        }

                        SRow {
                            STextBox {
                                span: 12; implicitHeight: 200;
                            }
                        }

                        SListgroup {
                            name: "List";
                            SJsonListModel {
                                id: jsonModel;
                                json: List.data;
                            }

                            model: jsonModel.model;
                        }
                    }
                },

                SContainer {
                    style: "fill";
                    name: "TableTest";

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
                }

            ]
        }
    }
}
