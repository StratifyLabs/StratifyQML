import QtQuick 2.6
import StratifyLabs.UI 2.0
import QtCharts 2.2

PieSeries {
  id: control;

  property string style;

  function updateStyle(){
    var i;
    console.log("Style changed " + count);
    for(i=0; i < count; i++){
      at(i).style = control.style;
    }
  }

  onStyleChanged: updateStyle();
  onCountChanged: updateStyle();

}
