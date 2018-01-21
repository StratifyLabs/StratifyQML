import QtQuick 2.8
import StratifyLabs.UI 2.1
import QtCharts 2.2

SplineSeries {
  id: control;

  property string chartStyle;

  property alias capStyle: control.capStyle;
  property alias lineStyle: control.style;
  property alias style: control.chartStyle;

  property SJsonModel model;

  SXYSeries { id: series; }

  onModelChanged: {
    //import the changes from the model to the Series
    series.importModel(control, control.model);
  }

  onChartStyleChanged: {
    series.updateStyle(control, chartStyle);
  }

  //color: control.attr.color;
  //width: control.attr.borderWidth;
  //pointLabelsFont.family: control.attr.fontText;
  //pointLabelsFont.pointSize: control.attr.fontSize;


}
