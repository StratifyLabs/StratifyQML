import QtQuick 2.6

SItem {
    id: root;
    type: "animation";

    property alias inTarget: inAnimation.target;
    property alias outTarget: outAnimation.target;
    property real duration: 250;
    property real dir: 1;

    function start(current, target){
        inAnimation.target = target;
        outAnimation.target = current;

        target.anchors.fill = undefined;
        current.anchors.fill = undefined;

        target.parent = main;
        target.width = main.width;
        target.height = main.height;

        target.visible = true;

        inAnimation.start();
        outAnimation.start();
    }

    PathAnimation {
        id: outAnimation;
        duration: root.duration;
        easing.type: Easing.InQuad;
        path: Path {
            id: outAnimationPath;
            startX: 0; startY: 0;
            PathCurve { id: outAnimationPathCurve; x: dir*main.width; y: 0; }
        }

        onStopped: target.visible = false;
    }

    PathAnimation {
        id: inAnimation;
        duration: root.duration;
        easing.type: Easing.InQuad;
        path: Path {
            id: inAnimationPath;
            startX: -1*dir*main.width; startY: 0;
            PathCurve { id: inAnimationPathCurve; x: 0; y: 0; }
        }
        onStopped: target.anchors.fill = target.parent;
    }
}
