import QtQuick 2.0

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
