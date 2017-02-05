import QtQuick 2.6
import "."

Text {
    id: control;

    property string icon;
    property string label;

    property alias properties: properties;
    property alias style: properties.style;
    property alias span: properties.span;

    property bool spin: false;
    property bool pulse: false;
    property real pulseSteps: 8;
    property real animationPeriod: 1200;

    SProperties {
        id: properties;
    }

    text: !spin && !pulse ? (icon + " " + label) : icon;

    font.family: icon != "" ? properties.fontIcon : properties.fontText;
    font.pointSize: properties.fontSize*1.2;
    color: enabled ? properties.textColor : properties.textColorMuted;
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter;
    elide: Text.ElideRight

    RotationAnimation on rotation {
        loops: Animation.Infinite;
        paused: !spin;
        from: 0;
        to: 360;
        duration: animationPeriod;
    }

    Timer {
        id: pulseTimer;
        running: pulse;
        repeat: true;
        interval: animationPeriod/pulseSteps;
        onTriggered: {
            control.rotation += 360/pulseSteps;
        }
    }
}
