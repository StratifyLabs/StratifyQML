import QtQuick 2.6
import StratifyLabs.UI 2.0
import QtCharts 2.2

PieSeries {
  id: control;

  property string style;

  function selectStyle(idx){
    var i = idx % 6;
    switch(i){
    case 0: return "primary";
    case 1: return "secondary";
    case 2: return "info";
    case 3: return "success";
    case 4: return "danger";
    case 5: return "warning";
    }
    return "default";
  }

  function updateStyle(){
    var i;
    for(i=0; i < count; i++){
      at(i).idx = i;
      at(i).count = count;
      at(i).style = control.style;

      if( (control.style === "") || (control.style === "default") ){
        at(i).isGradient = false;
        at(i).style = selectStyle(i);
      } else {
        at(i).isGradient = true;
      }

    }
  }

  onStyleChanged: updateStyle();
  onCountChanged: updateStyle();

}
