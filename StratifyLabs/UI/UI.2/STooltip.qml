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
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import StratifyLabs.UI 2.0

ToolTip {
    id: control;

    property alias style: attr.style;
    property alias span: attr.span;
    property alias attr: attr;

    delay: STheme.tooltip_delay;
    timeout: 2000;
    visible: parent ? parent.hovered : false;

    SAttributes {
        id: attr;
        fontSize: STheme.font_size_small;
        fontColor: STheme.tooltip_color;
        color: STheme.tooltip_bg;
        borderRadius: STheme.border_radius_base;
        borderColor: STheme.tooltip_bg;
    }

    enter: Transition {
        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: control.delay/5 }
    }

    exit: Transition {
        NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: control.delay/5; }
    }

    background: Rectangle {
        color: attr.color;
        radius: attr.borderRadius;
        border.color: attr.color;
        border.width: attr.borderWidth;
    }

    contentItem: Text {
        text: control.text;
        font.family: attr.fontText;
        font.pixelSize: attr.fontSize;
        font.weight: attr.fontWeight;
        color: attr.fontColor;
    }
}
