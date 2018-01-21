import QtQuick 2.8
import StratifyLabs.UI 2.1
import QtCharts 2.2

LineSeries {
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

  width: 3;
  //pointLabelsFont.family: STheme.font_family_base.fam;
  //pointLabelsFont.pointSize: control.attr.fontSize;


}
