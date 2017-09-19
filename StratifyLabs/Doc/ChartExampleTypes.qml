import QtQuick 2.6
import StratifyLabs.UI 2.1
import QtCharts 2.2

SRow {
  id: control;

  SChart {
    span: 4;
    style: "text-h1 hide-legend";
    title: "Pie";
    SPieSeries {
      id: pieSeries;
      SPieSlice {
        label: "1"; value: 25;
      }
      SPieSlice {
        label: "2"; value: 25;
      }

      SPieSlice {
        label: "3"; value: 50;
      }
    }
  }

  SJsonModel {
    id: xydata;
    json: '{ "data": [ {"x": 0, "y": 0}, {"x": 1, "y": 1}, {"x": 2, "y": 4}, {"x": 3, "y": 9} ]}';
  }

  SChart {
    span: 4;
    style: "text-h1 hide-legend";
    title: "Line";
    SLineSeries {
      style: "line-dot";
      model: xydata;
    }
  }

  SChart {
    span: 4;
    style: "text-h1 hide-legend";
    title: "Spline";
    SSplineSeries {
      style: "line-dash";
      model: xydata;
    }
  }
}
