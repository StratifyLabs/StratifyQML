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
    property string headingBackgroundColor: theme.panel_default_heading_bg;
    property real headingFontSize: theme.font_size_base;
    property string headingColor: textColor;
    property alias body: panelBodyText.text;
    property alias heading: panelHeadingText.text;
    property alias footer: panelFooterText.text;
    property alias contentsHeight: contentsContainer.height;
    borderColor: theme.panel_default_border;


    implicitWidth: blockWidth ? parent.width : (panelHeading.width);
    implicitHeight: (panelHeading.visible ? panelHeading.height : 0) + panelBody.height + (panelFooter.visible ? panelFooter.height : 0);
    blockWidth: true;

    onStyleChanged: {
        var items = parseStyle();
        var i;
        for(i=0; i < items.length; i++){
            if( items[i] === "panel-primary" ){
                headingBackgroundColor = theme.panel_primary_heading_bg;
                borderColor = theme.panel_primary_border;
                headingColor = theme.panel_primary_text;
            } else if( items[i] === "panel-success" ){
                headingBackgroundColor = theme.panel_success_heading_bg;
                borderColor = theme.panel_success_border;
                headingColor = theme.panel_success_text;
            } else if( items[i] === "panel-danger" ){
                headingBackgroundColor = theme.panel_danger_heading_bg;
                borderColor = theme.panel_danger_border;
                headingColor = theme.panel_danger_text;
            } else if( items[i] === "panel-warning" ){
                headingBackgroundColor = theme.panel_warning_heading_bg;
                borderColor = theme.panel_warning_border;
                headingColor = theme.panel_warning_text;
            } else if( items[i] === "panel-info" ){
                headingBackgroundColor = theme.panel_info_heading_bg;
                borderColor = theme.panel_info_border;
                headingColor = theme.panel_info_text;
            } else if( items[i] === "panel-default" ){
                headingBackgroundColor = theme.panel_default_heading_bg;
                borderColor = theme.panel_default_border;
                headingColor = theme.panel_default_text;
            }
        }
    }

    SRoundedRectangle {
        id: panelHeading;
        topRadius: theme.panel_border_radius;
        color: headingBackgroundColor;
        borderColor: panelRoot.borderColor;
        borderWidth: 1;
        visible: panelHeadingText.text != "";

        implicitWidth: parent.width;
        implicitHeight: panelHeadingText.height;

        Text {
            id: panelHeadingText;
            topPadding: theme.padding_base_vertical;
            bottomPadding: theme.padding_base_vertical;
            leftPadding: theme.padding_base_horizontal;
            rightPadding: theme.padding_base_horizontal;
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

        topRadius: panelHeading.visible ? 0 : theme.panel_border_radius;
        bottomRadius: panelFooter.visible ? 0 : theme.panel_border_radius;
        color: theme.body_bg;
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
        bottomRadius: theme.panel_border_radius;
        color: headingBackgroundColor;
        borderColor: panelRoot.borderColor;
        borderWidth: 1;
        visible: panelFooterText.text != "";

        implicitWidth: parent.width;
        implicitHeight: visible ? panelHeadingText.height : 0;

        Text {
            id: panelFooterText;
            topPadding: theme.padding_base_vertical;
            bottomPadding: theme.padding_base_vertical;
            leftPadding: theme.padding_base_horizontal;
            rightPadding: theme.padding_base_horizontal;
            text: "";
            color: headingColor;
            font.pointSize: headingFontSize;
            font.family: textFont;
            font.weight: Font.Light;
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
        }
    }

}
