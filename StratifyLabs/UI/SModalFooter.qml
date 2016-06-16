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
import "."


SItem {
    default property alias data: contents.data;

    implicitWidth: parent.width;
    implicitHeight: column.height + padding_vertical*3;

    SColumn {
        id: column;
        alignment: Qt.AlignHCenter | Qt.AlignCenter;
        SHLine{ id: line; }
        SColumn {
            contents.x: padding_horizontal;
            contents.width: parent.width - 2*padding_horizontal;
            SRow { id: contents; }
        }

    }

}
