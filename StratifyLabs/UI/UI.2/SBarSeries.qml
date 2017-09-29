import QtQuick 2.6
import StratifyLabs.UI 2.1
import QtCharts 2.2

BarSeries {
  id: control;

  property string chartStyle;
  property color themeColor: STheme.brand_primary;

  property SJsonModel model;

  BarCategoryAxis {
    id: categoryAxis;
    onCategoriesChanged: {
      console.log("Categories are " + categories);
    }
  }

  onModelChanged: {
    control.clear();
    var object = JSON.parse(control.model.json);
    var i;
    categoryAxis.clear();
    categoryAxis.categories = object.categories;
    for(i=0; i < object.sets.length; i++){
      control.append(object.sets[i].label, object.sets[i].values);
    }
  }

  function selectColor(idx){
    var i = idx % 6;
    switch(i){
    case 0: return STheme.brand_primary;
    case 1: return STheme.brand_success;
    case 2: return STheme.brand_secondary;
    case 3: return STheme.brand_danger;
    case 4: return STheme.brand_info;
    case 5: return STheme.brand_warning;
    }
    return STheme.gray_darker;
  }

  function updateStyle(){
    var i;
    var items = chartStyle.split(" ");
    for(i=0; i < items.length; i++){
      if( items[i] === "primary" ){
        themeColor = Qt.binding(function(){ return STheme.brand_primary; });
      } else if( items[i] === "secondary" ){
        themeColor = Qt.binding(function(){ return STheme.brand_secondary; });
      } else if( items[i] === "info" ){
        themeColor = Qt.binding(function(){ return STheme.brand_info; });
      } else if( items[i] === "success" ){
        themeColor = Qt.binding(function(){ return STheme.brand_success; });
      } else if( items[i] === "danger" ){
        themeColor = Qt.binding(function(){ return STheme.brand_danger; });
      } else if( items[i] === "warning" ){
        themeColor = Qt.binding(function(){ return STheme.brand_warning; });
      }
    }


    for(i=0; i < count; i++){
      if( (control.chartStyle === "") || (control.chartStyle === "default") ){
        at(i).color = selectColor(i);
      } else {
        at(i).color = Qt.darker(themeColor, 0.6 + idx * 1.0 / count);
      }

    }
  }

  onChartStyleChanged: updateStyle();
  onCountChanged: updateStyle();
}
