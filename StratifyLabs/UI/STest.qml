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
import "Fa-4.5.0.js" as Fa
import "SCustomize.js" as Theme
import "STestListText.js" as List;


SContainer {
    id: top;

    SRow {
        SColumn {
            SCarousel{
                id: carousel1;
                x:10;
                y: 10;
                width: 400;
                height: 300;
                model: ListModel {
                    id: listModel;
                    Component.onCompleted: {
                        var xhr = new XMLHttpRequest();
                        var source = "http://www.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"
                        var jsonResponse;
                        xhr.open("GET", source);
                        xhr.onreadystatechange = function() {
                            if (xhr.readyState === XMLHttpRequest.DONE){
                                jsonResponse = xhr.responseText;
                                // handling misformatted JSON from Flickr
                                jsonResponse = jsonResponse.replace(/\\\'/g, "\'");
                                console.log("#### JSON response: ", jsonResponse);
                                var jsonObj = JSON.parse(jsonResponse);

                                for (var i in jsonObj["items"]) {
                                    var item = jsonObj["items"][i];
                                    // model ROLE "source" is to display the image,
                                    // model ROLE "caption" is to show the text
                                    listModel.append({"source" : item["media"]["m"], "caption" : item["title"]});
                                }
                            }
                        }
                        xhr.send();
                    }

                }
            }

            SCarousel{
                x:10;
                anchors.left: parent.left;
                anchors.top: carousel1.bottom;
                width: 400;
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
            span: 4;
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

            SHline{}

            SRow {
                SButton{ span: 6; style: "btn-default xs center middle"; text: "Extra Small"; }
                SButton{ span: 6; style: "btn-default sm center middle"; text: "Small";
                    SPopover{ content: "Default Button Middle"; style: "top"; }
                }
            }

            SRow {
                SButton{ span: 6; style: "btn-default center middle"; text: "Default";
                    STooltip{ text: "Default Button Middle"; style: "top"; }
                }
                SButton{ span: 6; style: "btn-default lg center middle"; text: "Large";
                    STooltip{ text: "Default Large Button Middle"; style: "top"; }
                }
            }


            SRow {
                SButton{ id: blockButton; span: 6; style: "btn-lg btn-default center middle block"; text: "Block";
                    tooltip: STooltip{ target: blockButton; parent: top; text: "Large Center Middle Block"; style: "right"; }
                }
                SButton{ span: 6; style: "kg center middle"; text: "Default"; }
            }
        }

        SColumn {
            span: 4;
            SAlert { style: "alert-success"; text: "<b>Alert!</b> Success"; }
            SAlert { style: "alert-info"; text: "<b>Alert!</b> Info"; }
            SAlert { style: "alert-warning"; text: "<b>Alert!</b> Warning"; }
            SAlert { style: "alert-danger"; text: "<b>Alert!</b> Danger"; }
            SWell { style: "well-lg"; text: "Large Well"; }
            SWell { style: "well-sm"; text: "Small Well"; }
            SWell { style: "well-default"; text: "Well"; }

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

            SDropdown{ style: "btn-default"; text: "Hello"; }
        }

        SColumn {
            span: 4;
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
                    span: 12; height: 200;
                }
            }

            SRow {
                SRadioButtonControl { id: radioButtonControl; }
                SRadioButton { control: radioButtonControl; text: "Option 1"; }
                SRadioButton { control: radioButtonControl; text: "Option 2"; }
                SRadioButton { control: radioButtonControl; text: "Option 3"; }
            }

            //SRow {
                SListgroup { name: "List"; json: List.data; }
            //}


        }

    }

}
