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
    id: panelRoot;
    default property alias data: contents.data;
    property string headingBackgroundColor: StratifyUI.panel_default_heading_bg;
    property real headingFontSize: StratifyUI.font_size_base;
    property string headingColor: textColor;
    property alias body: panelBodyText.text;
    property alias heading: panelHeadingText.text;
    property alias footer: panelFooterText.text;
    property alias contentsHeight: contentsContainer.height;
    borderColor: StratifyUI.panel_default_border;


    implicitWidth: blockWidth ? parent.width : (panelHeading.width);
    implicitHeight: (panelHeading.visible ? panelHeading.height : 0) + panelBody.height + (panelFooter.visible ? panelFooter.height : 0);
    blockWidth: true;

    onStyleChanged: {
        var items = parseStyle();
        var i;
        for(i=0; i < items.length; i++){
            if( items[i] === "panel-primary" ){
                headingBackgroundColor = StratifyUI.panel_primary_heading_bg;
                borderColor = StratifyUI.panel_primary_border;
                headingColor = StratifyUI.panel_primary_text;
            } else if( items[i] === "panel-success" ){
                headingBackgroundColor = StratifyUI.panel_success_heading_bg;
                borderColor = StratifyUI.panel_success_border;
                headingColor = StratifyUI.panel_success_text;
            } else if( items[i] === "panel-danger" ){
                headingBackgroundColor = StratifyUI.panel_danger_heading_bg;
                borderColor = StratifyUI.panel_danger_border;
                headingColor = StratifyUI.panel_danger_text;
            } else if( items[i] === "panel-warning" ){
                headingBackgroundColor = StratifyUI.panel_warning_heading_bg;
                borderColor = StratifyUI.panel_warning_border;
                headingColor = StratifyUI.panel_warning_text;
            } else if( items[i] === "panel-info" ){
                headingBackgroundColor = StratifyUI.panel_info_heading_bg;
                borderColor = StratifyUI.panel_info_border;
                headingColor = StratifyUI.panel_info_text;
            } else if( items[i] === "panel-default" ){
                headingBackgroundColor = StratifyUI.panel_default_heading_bg;
                borderColor = StratifyUI.panel_default_border;
                headingColor = StratifyUI.panel_default_text;
            }
        }
    }

    SRoundedRectangle {
        id: panelHeading;
        topRadius: StratifyUI.panel_border_radius;
        color: headingBackgroundColor;
        borderColor: panelRoot.borderColor;
        borderWidth: 1;
        visible: panelHeadingText.text != "";

        implicitWidth: parent.width;
        implicitHeight: panelHeadingText.height;

        Text {
            id: panelHeadingText;
            topPadding: StratifyUI.padding_base_vertical;
            bottomPadding: StratifyUI.padding_base_vertical;
            leftPadding: StratifyUI.padding_base_horizontal;
            rightPadding: StratifyUI.padding_base_horizontal;
            text: "";
            color: headingColor;
            font.pointSize: headingFontSize;
            font.family: textFont;
            font.weight: Font.Light;
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
        }
    }

    SRoundedRectangle {
        id: panelBody;
        y: !panelHeading.visible ? 0 : panelHeading.height - 2*pixelRatio*panelHeading.borderWidth - borderWidth;

        topRadius: panelHeading.visible ? 0 : StratifyUI.panel_border_radius;
        bottomRadius: panelFooter.visible ? 0 : StratifyUI.panel_border_radius;
        color: StratifyUI.body_bg;
        borderColor: panelRoot.borderColor;
        borderWidth: 1;
        width: parent.width;
        implicitHeight: contentsContainer.height;

        SContainer {
            id: contentsContainer;
            SColumn {
                id: contents;
                Text {
                    id: panelBodyText;
                    width: parent.width-2;
                    text: "";
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
                    font.pointSize: fontSize;
                    font.family: textFont;
                    font.weight: Font.Light;
                    color: panelRoot.textColor;
                }
            }
        }
    }

    SRoundedRectangle {
        id: panelFooter;
        y: panelBody.y + panelBody.height - 2*pixelRatio*panelHeading.borderWidth;
        anchors.left: panelBody.left;
        bottomRadius: StratifyUI.panel_border_radius;
        color: headingBackgroundColor;
        borderColor: panelRoot.borderColor;
        borderWidth: 1;
        visible: panelFooterText.text != "";

        implicitWidth: parent.width;
        implicitHeight: visible ? panelHeadingText.height : 0;

        Text {
            id: panelFooterText;
            topPadding: StratifyUI.padding_base_vertical;
            bottomPadding: StratifyUI.padding_base_vertical;
            leftPadding: StratifyUI.padding_base_horizontal;
            rightPadding: StratifyUI.padding_base_horizontal;
            text: "";
            color: headingColor;
            font.pointSize: headingFontSize;
            font.family: textFont;
            font.weight: Font.Light;
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
        }
    }

}
