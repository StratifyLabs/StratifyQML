import QtQuick 2.6
import StratifyLabs.UI 2.0
import QtCharts 2.2

PieSlice {
  id: control;

  property string style;

  property var attr: SAttributes {
    style: control.style;
    color: STheme.btn_primary_bg;
    borderColor: STheme.btn_primary_border;
  }

  //borderColor: control.attr.borderColor;
  color: Qt.darker(attr.color, (startAngle % 90 + 57) / 90.0);
  borderWidth: control.attr.borderWidth;
  labelColor: control.attr.fontColor;
  labelFont.family: attr.fontText;
  labelFont.pointSize: attr.fontSize;
  labelFont.weight: attr.fontWeight;
}
