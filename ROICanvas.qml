import QtQuick 2.0


Rectangle {

    visible: true
    z: 1.0
    anchors.fill: parent
    color: "transparent"

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        property int x0
        property int x1
        property int y0
        property int y1
        onPressed: {

            console.log("trigger pressed event");
            console.log("press pos: x = " + mouse.x + " y = " + mouse.y )
            x0 = mouse.x
            y0 = mouse.y

        }

        onPositionChanged: {
            //console.log("trigger position changed event");
        }

        onReleased: {

            console.log("trigger release event");
            console.log("release pos: x = " + mouse.x + " y = " + mouse.y )
            x1 = mouse.x
            y1 = mouse.y

        }

    }

//    function drawRect(){
//        var p = new Qt.QPainter();

//    }


}
