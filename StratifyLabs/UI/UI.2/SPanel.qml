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

Item {
    id: panelRoot;

    property alias style: attr.style;
    property alias span: attr.span;
    property alias attr: attr;

    default property alias data: contents.data;
    property alias heading: panelHeadingText.text;
    property alias footer: panelFooterText.text;

    SAttributes {
        id: attr;
        borderWidth: STheme.panel_border_width;
        blockWidth: true;
        borderColor: STheme.panel_default_border;
        color: STheme.panel_default_heading_bg;

        property real headingFontSize: STheme.font_size_base;
        property real footerFontSize: STheme.font_size_base;

        onStyleChanged: {
            var items = parseStyle();
            var i;
            for(i=0; i < items.length; i++){
                if( items[i] === "panel-primary" ){
                    attr.color = Qt.binding(function(){ return STheme.panel_primary_heading_bg; });
                    attr.borderColor = Qt.binding(function(){ return STheme.panel_primary_border; });
                    fontColor = Qt.binding(function(){ return STheme.panel_primary_text; });
                } else if( items[i] === "panel-secondary" ){
                    attr.color = Qt.binding(function(){ return STheme.panel_secondary_heading_bg; });
                    attr.borderColor = Qt.binding(function(){ return STheme.panel_secondary_border; });
                    fontColor = Qt.binding(function(){ return STheme.panel_secondary_text; });
                } else if( items[i] === "panel-success" ){
                    attr.color = Qt.binding(function(){ return STheme.panel_success_heading_bg; });
                    attr.borderColor = Qt.binding(function(){ return STheme.panel_success_border; });
                    fontColor = Qt.binding(function(){ return STheme.panel_success_text; });
                } else if( items[i] === "panel-danger" ){
                    attr.color = Qt.binding(function(){ return STheme.panel_danger_heading_bg; });
                    attr.borderColor = Qt.binding(function(){ return STheme.panel_danger_border; });
                    fontColor = Qt.binding(function(){ return STheme.panel_danger_text; });
                } else if( items[i] === "panel-warning" ){
                    attr.color = Qt.binding(function(){ return STheme.panel_warning_heading_bg; });
                    attr.borderColor = Qt.binding(function(){ return STheme.panel_warning_border; });
                    fontColor = Qt.binding(function(){ return STheme.panel_warning_text; });
                } else if( items[i] === "panel-info" ){
                    attr.color = Qt.binding(function(){ return STheme.panel_info_heading_bg; });
                    attr.borderColor = Qt.binding(function(){ return STheme.panel_info_border; });
                    fontColor = Qt.binding(function(){ return STheme.panel_info_text; });
                } else if( (items[i] === "panel-naked") || (items[i] === "panel-default") ){
                    attr.color = Qt.binding(function(){ return STheme.panel_default_heading_bg; });
                    attr.borderColor = Qt.binding(function(){ return STheme.panel_default_border; });
                    fontColor = Qt.binding(function(){ return STheme.panel_default_text; });
                }
            }
        }
    }


    //implicitWidth: blockWidth ? parent.width : (panelHeading.width);
    implicitHeight: (panelHeading.visible ? panelHeading.height : 0) + panelBody.height + (panelFooter.visible ? panelFooter.height : 0);

    //Panel Heading
    SRoundedRectangle {
        id: panelHeading;
        topRadius: STheme.panel_border_radius;
        color: attr.color;
        borderColor: attr.borderColor;
        borderWidth: attr.borderWidth;
        visible: panelHeadingText.text != "";
        width: parent.width;
        implicitWidth: panelHeadingText.width;
        implicitHeight: panelHeadingText.height;

        Text {
            id: panelHeadingText;
            topPadding: attr.paddingVertical;
            bottomPadding: attr.paddingVertical;
            leftPadding: attr.paddingHorizontal;
            rightPadding: attr.paddingHorizontal;
            text: "";
            color: attr.fontColor;
            font.pointSize: attr.headingFontSize;
            font.family: attr.fontText;
            font.weight: Font.Light;
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
        }
    }

    SRoundedRectangle {
        id: panelBody;
        y: !panelHeading.visible ? 0 : panelHeading.height - 2*pixelRatio*panelHeading.borderWidth - borderWidth;

        topRadius: panelHeading.visible ? 0 : STheme.panel_border_radius;
        bottomRadius: panelFooter.visible ? 0 : STheme.panel_border_radius;
        color: STheme.body_bg;
        borderColor: attr.borderColor;
        borderWidth: attr.borderWidth;

        width: parent.width;
        implicitHeight: contents.height;

        SContainer {
            id: contents;
        }
    }

    SRoundedRectangle {
        id: panelFooter;
        y: panelBody.y + panelBody.height - 2*pixelRatio*panelHeading.borderWidth;
        anchors.left: panelBody.left;
        bottomRadius: attr.borderRadius;
        color: attr.color;
        borderColor: attr.borderColor;
        borderWidth: attr.borderWidth;
        visible: panelFooterText.text != "";

        width: parent.width;
        implicitHeight: visible ? panelHeadingText.height : 0;

        Text {
            id: panelFooterText;
            topPadding: attr.paddingVertical;
            bottomPadding: attr.paddingVertical;
            leftPadding: attr.paddingHorizontal;
            rightPadding: attr.paddingHorizontal;
            text: "";
            color: attr.fontColor;
            font.pointSize: attr.footerFontSize;
            font.family: attr.fontText;
            font.weight: Font.Light;
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
        }
    }

}
