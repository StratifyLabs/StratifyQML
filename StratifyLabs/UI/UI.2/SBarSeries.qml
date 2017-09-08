import QtQuick 2.6
import StratifyLabs.UI 2.1
import QtCharts 2.2

BarSeries {
  id: control;

  property string sChartStyle;

  property SJsonModel model;

  onModelChanged: {
    //import the changes from the model to the Series

    control.removePoints(0, control.count);
    for(var i = 0; i < model.count; i++){
      var object = model.get(i);
      control.append(object.x, object.y);
    }
  }

  function exportJson(){
    //export data in JSON format
  }

  property var attr: SAttributes {
    style: sChartStyle;
    color: STheme.brand_primary;
    borderColor: STheme.btn_primary_border;

    onStyleChanged: {
      var items = parseStyle();
      for(var i = 0; i < items.length; i++){
        if( (items[i] === "line-dot") ){
          control.style = Qt.DotLine;
        } else if( (items[i] === "line-dash") ){
          control.style = Qt.DashLine;
        } else if( (items[i] === "line-solid") ){
          control.style = Qt.SolidLine;
        } else if( (items[i] === "line-none") ){
          control.style = Qt.NoPen;
        } else if( (items[i] === "line-dash-dot") ){
          control.style = Qt.DashDotLine;
        } else if( (items[i] === "line-dash-dot-dot") ){
          control.style = Qt.DashDotDotLine;
        } else if( (items[i] === "cap-flat") ){
          control.capStyle = Qt.FlatCap;
        } else if( (items[i] === "cap-square") ){
          control.capStyle = Qt.SquareCap;
        } else if( (items[i] === "cap-round") ){
          control.capStyle = Qt.RoundCap;
        }
      }
    }
  }

  color: control.attr.color;
  width: control.attr.borderWidth;
  pointLabelsFont.family: control.attr.fontText;
  pointLabelsFont.pointSize: control.attr.fontSize;


}
