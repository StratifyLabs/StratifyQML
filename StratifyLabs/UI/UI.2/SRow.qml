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
import QtQuick.Layouts 1.3
import StratifyLabs.UI 2.0

GridLayout {
    id: control;

    property alias attr: attr;
    property alias style: attr.style;

    width: parent ? (attr.fillWidth ? parent.width : undefined) : undefined;
    height: parent ? (attr.fillHeight ? parent.height : undefined) : undefined;

    SSizeAttributes {
        id: attr;
        type: "row";
        fillWidth: true;
        span: STheme.grid_columns;
    }

    onVisibleChanged: adjustWidth();
    rowSpacing: attr.paddingVertical;
    columnSpacing: attr.paddingHorizontal;
    columns: attr.span;

    function alignChildren(){
        for(var i = 0; i < children.length; i++){

            if( children[i].attr !== undefined ){

                if( children[i].attr.blockWidth === true ){
                    children[i].Layout.fillWidth = true;
                    children[i].Layout.minimumWidth = children[i].implicitWidth;
                } else {
                    children[i].Layout.fillWidth = false;
                }

                if( children[i].attr.fillHeight === true ){
                    children[i].Layout.fillHeight = true;
                    children[i].Layout.minimumHeight = children[i].implicitHeight;
                } else {
                    children[i].Layout.fillHeight = false;
                }

                var span = children[i].attr.span;
                if( (span > columns) || (span < 0) ){
                    span = columns;
                }

                children[i].Layout.columnSpan = span;
                children[i].Layout.alignment = children[i].attr.alignment;

            } else {
                children[i].Layout.fillWidth = true;
            }
        }
    }

    function adjustWidth(){
        for(var i = 0; i < children.length; i++){
            var w;
            var spacingInRow;
            var span;

            if( children[i].attr !== undefined ){
                if( children[i].attr.span < 0 ){
                    span = columns;
                } else {
                    span = children[i].attr.span;
                }

                spacingInRow = 0;
                if( span >= columns ){
                    span = columns;
                }

                children[i].Layout.columnSpan = span;

                if( children[i].attr.fillWidth === true ){
                    w = (width - spacingInRow) * span / columns;
                    children[i].Layout.maximumWidth = w;
                }
            }
        }
    }

    Connections {
        target: STheme;
        onIsScreenSmChanged: {
            if( control.attr.type == "row" ){
                if( STheme.isScreenSm === true ){
                    columns = STheme.grid_columns_sm;
                } else {
                    columns = STheme.grid_columns;
                }
            }
        }
    }

    onWidthChanged: {
        adjustWidth();
    }


    Component.onCompleted: {
        alignChildren();
        adjustWidth();
    }

}

