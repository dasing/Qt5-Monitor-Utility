import QtQuick 2.0
import qmlroi 1.0

Rectangle {

    visible: true
    z: 1.0
    anchors.fill: parent
    color: "transparent"

    property alias roidrawcanvas: roidrawcanvas
    property alias arealist: arealist
    property alias mouseArea: mouseArea
    property alias rects: roidrawcanvas.rects
    property alias rectsListSize: roidrawcanvas.rectsListSize


    Canvas{
        id: roidrawcanvas
        anchors.fill: parent

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

                //copyAreaList()
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


            onPositionChanged: {
                //console.log("trigger position changed event");
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

    SelectionAreaList{
        id: arealist
//        areaList: [
//            SelectionArea{ index: 0
//                            x: 1
//                            y: 1
//                            width: 1
//                            height: 1
//            }
//        ]
    }

    SelectionAreaList{
        id: arealist2
    }

    function listAllRects(){

        var size = roidrawcanvas.rects.length

        console.log("in listAllRects")

        for( var i=0; i<size; i++ ){
            console.log( roidrawcanvas.rects[i] )
        }
    }

    function copyAreaList(){

        var size = arealist.count()
        var size2 = arealist2.count()

        for( var i=0; i<size; i++ ){
            arealist2.append( arealist.area(i) )
        }

        arealist2.listAllArea(2)

        //arealist2.removeAt()

    }

}
