import QtQuick 2.6
import QtQuick.Window 2.2
import "SCustomize.js" as Theme
import "Fa-4.5.0.js" as Fa

Item {
    id: root;
    property real progress: 0.1;
    property real pixelRatio: Screen.devicePixelRatio;
    property alias iconVisible: icon.visible;
    property alias textVisible: text.visible;

    onProgressChanged: canvas.requestPaint();

    Canvas {
        id: canvas;
        //double the height and scale down for retina displays
        width: parent.width*pixelRatio;
        height: parent.height*pixelRatio;
        transform: Scale { xScale: 1.0/root.pixelRatio; yScale: 1.0/root.pixelRatio; }

        onPaint: {
            var ctx = getContext("2d");
            var x = width / 2;
            var y = height / 2;
            var prog = root.progress;
            if( prog < 0.0 ){
                prog = 0.0;
            }

            if( prog > 1.0 ){
                prog = 1.0;
            }

            ctx.clearRect(0, 0, width, height);

            ctx.beginPath();
            ctx.fillStyle = Theme.gray_lighter;
            ctx.moveTo(x, y);
            ctx.arc(x, y, width/2*0.98, 0, Math.PI*2, false);
            ctx.closePath();
            ctx.fill();

            ctx.beginPath();
            ctx.fillStyle = Theme.brand_primary;
            ctx.moveTo(x, y);
            ctx.arc(x, y, width/2, Math.PI*3/2, Math.PI*3/2 + prog*Math.PI*2, false);
            ctx.closePath();
            ctx.fill();

            ctx.beginPath();
            ctx.fillStyle = "#fff";
            ctx.moveTo(x, y);
            ctx.arc(x, y, width/2*main.contentWidthFactor, 0, Math.PI*2, false);
            ctx.closePath();
            ctx.fill();
        }
    }
}
