import QtQuick 2.6
import StratifyLabs.UI 2.0
import QtCharts 2.2

PieSlice {
  id: control;

  property string style;
  property real idx;
  property real count;
  property bool isGradient: true;

  property var attr: SAttributes {
    style: control.style;
    color: STheme.btn_primary_bg;
    borderColor: STheme.btn_primary_border;
  }

  //borderColor: control.attr.borderColor;
  color: isGradient ? Qt.darker(attr.color, 0.6 + idx * 1.0 / count) : attr.color;
  borderWidth: control.attr.borderWidth;
  labelColor: control.attr.fontColor;
  labelFont.family: attr.fontText;
  labelFont.pointSize: attr.fontSize;
  labelFont.weight: attr.fontWeight;
}
