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
import StratifyLabs.UI 2.0

Rectangle {

    property alias properties: properties;
    property alias style: properties.style;
    property alias span: properties.span;

    SProperties {
        id: properties;
        type: "hline";
        backgroundColor: StratifyUI.panel_default_border;
        borderColor: StratifyUI.panel_default_border;
        borderWidth: 0;
        blockWidth: true;
    }

    implicitHeight: properties.paddingVertical*2;

    y: properties.paddingVertical;
    width: parent.width;
    height: 1;
    color: properties.backgroundColor;
    border.color: properties.borderColor;
    border.width: properties.borderWidth;

}
