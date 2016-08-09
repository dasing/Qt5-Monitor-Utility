import QtQuick 2.0
import qmlroi 1.0

Rectangle {

    visible: true
    z: 1.0
    anchors.fill: parent
    color: "transparent"


    property alias roidrawcanvas: roidrawcanvas
    property alias gridviewcanvas: gridviewcanvas
    property alias mouseArea: mouseArea
    property alias rects: roidrawcanvas.rects
    property alias rectsListSize: roidrawcanvas.rectsListSize


    Canvas{
        id: roidrawcanvas
        anchors.fill: parent
        enabled: false

        property int x0
        property int x1
        property int y0
        property int y1
        property int rectCount: 0
        property var rects:[ ]
        property int rectsListSize: 0

        onPaint: {
            console.log("canvas is on paint");

            //draw rectangle to canvas
            var ctx = getContext('2d')
            ctx.strokeStyle = "red"
            ctx.strokeRect(x0, y0, x1-x0, y1-y0 )

            //add new rectangle to list, rectCount should > 0 because when the canvas is initialized, the program will execute here
            if( rectCount > 0 ){

                var width = x1-x0+1
                var height = y1-y0+1
                var newRect = rectCount + ";" + x0 + ";" + y0 + ";" + width + ";" + height


                console.log(newRect)
                rects.push(newRect )

                listAllRects()
                //arealist.addSelectionArea( rectCount, x0, y0, x1-x0+1, y1-y0+1 )
                //arealist.listAllArea(0)
                //console.log(arealist.areaList[rectCount-1].index)


            }

            rectsListSize = rectCount

              /*TO DO: implementation of temporary rectangle*/
//            if( mouseArea.pressed ){
//                ctx.clearRect( x0-)
//            }

        }

        MouseArea{

            id: mouseArea
            anchors.fill: parent



            onPressed: {

                console.log("trigger pressed event");
                console.log("press pos: x = " + mouse.x + " y = " + mouse.y )
                roidrawcanvas.x0 = mouse.x
                roidrawcanvas.y0 = mouse.y
                //canvas.requestPaint()

            }

            onReleased: {

                console.log("trigger release event");
                console.log("release pos: x = " + mouse.x + " y = " + mouse.y )
                roidrawcanvas.x1 = mouse.x
                roidrawcanvas.y1 = mouse.y

                roidrawcanvas.rectCount = roidrawcanvas.rectCount+1
                console.log("rectCount = " + roidrawcanvas.rectCount )
                roidrawcanvas.requestPaint()
            }
        }
    }

    Canvas{

        id: gridviewcanvas
        anchors.fill: parent
        enabled: false

        property int x0
        property int x1
        property int y0
        property int y1

        property int divWidth: 0
        property int divHeight: 0


        onDivHeightChanged: {
            //console.log("divWidth changed to " + divWidth )
            //console.log("divHeight changed to " + divHeight )

            gridviewcanvas.requestPaint()
        }

        onPaint: {

            console.log("canvas2 is on paint");
            if( divHeight > 0 && divHeight > 0 ){
                console.log("start to draw line")
                console.log("canvas size = " + gridviewcanvas.canvasSize )

                var ctx = getContext('2d')
                ctx.fillStyle = Qt.rgba(128, 128, 128, 0.8 )

                //draw vertical line
                var x_pos = 0
                var y_pos = 0
                var diffWidth = gridviewcanvas.canvasSize.width/divWidth
                var diffHeight = gridviewcanvas.canvasSize.height/divHeight


               //console.log( "diffWidth = " + diffWidth )
                for( var i=0; i<divWidth-1; i++ ){

                    x_pos += diffWidth
                    //console.log( "x_pos = " + x_pos )
                    ctx.fillRect( x_pos, 0, 1, gridviewcanvas.canvasSize.height )

                }

                //draw horizontal line
                for( i=0; i<divHeight-1; i++ ){

                    y_pos += diffHeight
                    //console.log( "y_pos = " + y_pos )
                    ctx.fillRect( 0, y_pos, gridviewcanvas.canvasSize.width, 1 )

                }




            }



        }

        MouseArea{

            id: gridviewMouseArea
            anchors.fill: parent

//            onPressed: {

//                console.log("trigger pressed event");
//                console.log("press pos: x = " + mouse.x + " y = " + mouse.y )
//                gridviewcanvas.x0 = mouse.x
//                gridviewcanvas.y0 = mouse.y
//                //canvas.requestPaint()

//            }

//            onReleased: {

//                gridviewcanvas.x1 = mouse.x
//                gridviewcanvas.y1 = mouse.y

//                gridviewcanvas.requestPaint()
//            }
        }


    }

//    SelectionAreaList{
//        id: arealist

//    }


    function listAllRects(){
        var size = roidrawcanvas.rects.length
        console.log("in listAllRects")
        for( var i=0; i<size; i++ ){
            console.log( roidrawcanvas.rects[i] )
        }
    }


}
