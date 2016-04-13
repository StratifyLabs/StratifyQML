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

        SColumn {
            span: 6;
            SAlert { style: "alert-success"; text: "<b>Alert!</b> Success"; }
            SAlert { style: "alert-info"; text: "<b>Alert!</b> Info"; }
            SAlert { style: "alert-warning"; text: "<b>Alert!</b> Warning"; }
            SAlert { style: "alert-danger"; text: "<b>Alert!</b> Danger"; }
            SWell { style: "well-lg"; text: "Large Well"; }
            SWell { style: "sm"; text: "Small Well"; }
            SWell { style: "default"; text: "Well"; }

            SRow { SText{ style: "left"; text: "Buttons:"; span:12; } }

            SRow {
                SButton{ span: 4; style: "btn-default center"; text: "Default"; }
                SButton{ span: 4; style: "btn-primary center"; text: "Primary"; }
                SButton{ span: 4; style: "btn-info center"; text: "Info"; }
            }

            SRow {
                SButton{ span: 4; style: "btn-success center"; text: "Success"; }
                SButton{ span: 4; style: "btn-warning center"; text: "Warning"; }
                SButton{ span: 4; style: "btn-danger center"; text: "Danger"; }
            }

            SRow { SText{ style: "left"; text: "Labels:"; span:12; } }

            SRow {
                SLabel{ span: 4; style: "label-default center sm middle"; text: "Default"; }
                SLabel{ span: 4; style: "label-primary center xs middle"; text: "Primary"; }
                SLabel{ span: 4; style: "label-info center lg middle"; text: "Info"; }
            }

            SRow {
                SLabel{ span: 4; style: "label-success center"; text: "Success"; }
                SLabel{ span: 4; style: "label-warning center"; text: "Warning"; }
                SLabel{ span: 4; style: "label-danger center"; text: "Danger"; }
            }
        }
    }
}
