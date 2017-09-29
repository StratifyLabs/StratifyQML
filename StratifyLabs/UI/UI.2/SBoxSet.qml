import QtQuick 2.8
import StratifyLabs.UI 2.1
import QtCharts 2.2

BoxSet {
  id: control;

  property string chartStyle;

  property alias capStyle: control.capStyle;
  property alias lineStyle: control.style;
  property alias style: control.chartStyle;

  property SJsonModel model;


  function importModel(){
    control.clear();
    for(var i = 0; i < control.model.count; i++){
      var object = model.get(i);
      control.append(object.x, object.y);
    }
  }

  onChartStyleChanged: {


  }

  //color: control.attr.color;
  //width: control.attr.borderWidth;
  //pointLabelsFont.family: control.attr.fontText;
  //pointLabelsFont.pointSize: control.attr.fontSize;


}
