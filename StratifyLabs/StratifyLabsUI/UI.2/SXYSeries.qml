import QtQuick 2.8
import StratifyLabs.UI 2.1


QtObject {

  function importModel(series, model){
    series.removePoints(0, control.count);
    for(var i = 0; i < model.count; i++){
      var object = model.get(i);
      series.append(object.x, object.y);
    }
  }

  function exportJson(){
    //export data in JSON format
    var json = "{}";

    return json;
  }

  function updateStyle(control, style){
    control.lineStyle = getLineStyle(style);
    control.capStyle = getCapStyle(style);
    control.color = getColor(style);
    control.width = getWidth(style);
  }

  function getWidth(style){
    var items = style.split(" ");
    for(var i = 0; i < items.length; i++){
      if( (items[i] === "xs") ){
        return STheme.chart_series_width_xs;
      } else if( (items[i] === "sm") ){
        return STheme.chart_series_width_sm;
      } else if( (items[i] === "lg") ){
        return STheme.chart_series_width_lg;
      } else if( (items[i] === "default") ){
        return STheme.chart_series_width;
      }
    }
    return STheme.chart_series_width;
  }

  function getColor(style){
    var items = style.split(" ");
    for(var i = 0; i < items.length; i++){
      if( (items[i] === "primary") ){
        return STheme.brand_primary;
      } else if( (items[i] === "secondary") ){
        return STheme.brand_secondary;
      } else if( (items[i] === "info") ){
        return STheme.brand_info;
      } else if( (items[i] === "success") ){
        return STheme.brand_success;
      } else if( (items[i] === "warning") ){
        return STheme.brand_warning;
      } else if( (items[i] === "danger") ){
        return STheme.brand_danger;
      } else if( (items[i] === "default") ){
        return STheme.gray_darker;
      }
    }
    return STheme.gray_darker;
  }

  function getLineStyle(style){
    var items = style.split(" ");
    for(var i = 0; i < items.length; i++){
      if( (items[i] === "line-dot") ){
        return Qt.DotLine;
      } else if( (items[i] === "line-dash") ){
        return Qt.DashLine;
      } else if( (items[i] === "line-solid") ){
        return Qt.SolidLine;
      } else if( (items[i] === "line-none") ){
        return Qt.NoPen;
      } else if( (items[i] === "line-dash-dot") ){
        return Qt.DashDotLine;
      } else if( (items[i] === "line-dash-dot-dot") ){
        return Qt.DashDotDotLine;
      }
    }
    return Qt.SolidLine;
  }

  function getCapStyle(style){
    var items = style.split(" ");
    for(var i = 0; i < items.length; i++){
      if( (items[i] === "cap-flat") ){
        return Qt.FlatCap;
      } else if( (items[i] === "cap-square") ){
        return Qt.SquareCap;
      } else if( (items[i] === "cap-round") ){
        return Qt.RoundCap;
      }
    }
    return Qt.FlatCap;
  }

}
