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
import "."

GridLayout {
    id: control;

    property alias properties: properties;
    property alias style: properties.style;

    width: parent ? parent.width : undefined;

    SProperties {
        id: properties;
        blockWidth: true;
        type: "row";
        span: StratifyUI.grid_columns;
    }

    onVisibleChanged: adjustWidth();
    rowSpacing: properties.paddingHorizontal;
    columns: properties.span;

    function alignChildren(){
        for(var i = 0; i < children.length; i++){

            if( children[i].properties !== undefined ){

                if( children[i].properties.blockWidth === true ){
                    children[i].Layout.fillWidth = true;
                }

                if( children[i].properties.fillHeight === true ){
                    children[i].Layout.fillHeight = true;
                }

                var span = children[i].properties.span;
                if( (span > columns) || (span < 1) ){
                    span = columns;
                }

                children[i].Layout.columnSpan = span;
                children[i].Layout.alignment = children[i].properties.alignment;

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
            if( children[i].properties !== undefined ){
                if( children[i].properties.span < 1 ){
                    span = columns;
                } else {
                    span = children[i].properties.span;
                }

                if( span >= columns ){
                    span = columns;
                    spacingInRow = 0;
                } else {
                    spacingInRow = (columns / span - 1)*rowSpacing;
                }

                children[i].Layout.columnSpan = span;

                if( children[i].properties.blockWidth === true ){
                    w = (width - spacingInRow) * span / columns;
                    children[i].Layout.maximumWidth = w;
                }
            }
        }
    }

    onWidthChanged: {
        if( properties.type === "row" ){
            if( width < StratifyUI.screen_sm ){
                columns = StratifyUI.grid_columns_sm;
            } else {
                columns = StratifyUI.grid_columns;
            }
        }
        adjustWidth();
    }


    Component.onCompleted: {
        alignChildren();
        adjustWidth();
    }

}

