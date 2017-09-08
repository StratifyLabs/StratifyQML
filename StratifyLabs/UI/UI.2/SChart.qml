import QtQuick 2.6
import StratifyLabs.UI 2.0
import QtCharts 2.2

ChartView {
  id: control;

  property alias style: attr.style;
  property alias span: attr.span;
  property alias attr: attr;

  SAttributes {
    id: attr;
    blockWidth: true;

    property real legendFontSize: STheme.font_size_base;
    property real legendFontWeight: Font.Normal;
    property bool legendIsVisible: true;

    backgroundColor: STheme.body_bg;
    color: STheme.chart_default_heading_bg;
    borderColor: STheme.chart_default_border;
    borderRadius: STheme.chart_border_radius;
    borderWidth: STheme.chart_border_width;
    fontColor: STheme.chart_default_text;

    onStyleChanged: {
      var items = parseStyle();
      for(var i = 0; i < items.length; i++){
        if( (items[i] === "legend-right") ){
          control.legend.alignment = Qt.AlignRight;
        } else if( (items[i] === "legend-left") ){
          control.legend.alignment = Qt.AlignLeft;
        } else if( (items[i] === "legend-top") ){
          control.legend.alignment = Qt.AlignTop;
        } else if( (items[i] === "legend-bottom") ){
          control.legend.alignment = Qt.AlignBottom;
        } else if( items[i] === "legend-bold" ){
          legendFontWeight = Font.Bold;
        } else if( items[i] === "legend-light" ){
          legendFontWeight = Font.Light;
        } else if( (items[i] === "legend-semi-bold") || items[i] === "text-demi-bold" ){
          legendFontWeight = Font.DemiBold;
        } else if( items[i] === "legend-extra-bold" ){
          legendFontWeight = Font.ExtraBold;
        } else if( items[i] === "legend-extra-light" ){
          legendFontWeight = Font.ExtraLight;
        } else if( items[i] === "legend-normal" ){
          legendFontWeight = Qt.binding(function(){ return STheme.font_family_base.name; });
          legendFontWeight = Font.Normal;
          control.legend.font.italic = false;
        } else if( items[i] === "text-italic" ){
          control.legend.font.italic = true;
        } else if( items[i] === "show-legend" ){
          legendIsVisible = true;
        } else if( items[i] === "hide-legend" ){
          legendIsVisible = false;
        } else if( items[i] === "legend-lg" ){
          legendFontSize = Qt.binding( function() { return STheme.font_size_large; });
        } else if( items[i] === "legend-sm" ){
          legendFontSize = Qt.binding( function() { return STheme.font_size_small; });
        } else if( items[i] === "legend-h1" ){
          legendFontSize = Qt.binding( function() { return STheme.font_size_h1; });
        } else if( items[i] === "legend-h2" ){
          legendFontSize = Qt.binding( function() { return STheme.font_size_h2; });
        } else if( items[i] === "legend-h3" ){
          legendFontSize = Qt.binding( function() { return STheme.font_size_h3; });
        } else if( items[i] === "legend-h4" ){
          legendFontSize = Qt.binding( function() { return STheme.font_size_h4; });
        } else if( items[i] === "legend-h5" ){
          legendFontSize = Qt.binding( function() { return STheme.font_size_h5; });
        } else if( items[i] === "legend-h6" ){
          legendFontSize = Qt.binding( function() { return STheme.font_size_h6; });
        }
      }
    }
  }

  backgroundColor: attr.color;
  backgroundRoundness: attr.borderRadius;
  plotAreaColor: attr.backgroundColor;

  titleColor: attr.fontColor;
  titleFont.family: attr.fontText;
  titleFont.pointSize: attr.fontSize;
  titleFont.weight: attr.fontWeight;

  legend.font.weight: attr.legendFontWeight;
  legend.font.pointSize: attr.legendFontSize;
  legend.labelColor: attr.fontColor;
  legend.borderColor: attr.borderColor;
  legend.visible: attr.legendIsVisible;

  antialiasing: true
  implicitHeight: 400;

}
