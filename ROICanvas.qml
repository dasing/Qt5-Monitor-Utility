import QtQuick 2.0
import qmlroi 1.0

Rectangle {

    id: window
    visible: true
    z: 1.0
    anchors.fill: parent
    color: "transparent"

    property alias roidrawcanvas: roidrawcanvas
    property alias gridviewcanvas: gridviewcanvas
    property alias mouseArea: mouseArea

    property int rectCount: 0
    property var rects:[ ]
    property int rectsListSize: 0
    //signal addNewRect( var rect )

    Canvas{

        id: roidrawcanvas
        anchors.fill: parent
        enabled: false

        property int x0
        property int x1
        property int y0
        property int y1
        property int paraOnPaint: 0


        onPaint: {
            console.log("canvas is on paint");

            //draw rectangle to canvas
             var ctx = getContext('2d')
            ctx.strokeStyle = "red"

            if( paraOnPaint === 0 ){

                //add new rectangle to list, rectCount should > 0 because when the canvas is initialized, the program will execute here
                if( window.rectCount > 0 ){

                    ctx.strokeRect(x0, y0, x1-x0, y1-y0 )

                    var width = x1-x0+1
                    var height = y1-y0+1
                    var newRect = window.rectCount + ";" + x0 + ";" + y0 + ";" + width + ";" + height

                    console.log(newRect)
                    window.rects.push(newRect ) //push new rect information to list, and will be updated to frame filter
                    //addNewRect(newRect) //send signal to ChartInfo

                    listAllRects()


                }

                window.rectsListSize = window.rectCount

                  /*TO DO: implementation of temporary rectangle*/
    //            if( mouseArea.pressed ){
    //                ctx.clearRect( x0-)
    //            }


            }else if( paraOnPaint === 1 ){

                //remove rectangle
                ctx.clearRect( 0, 0, roidrawcanvas.canvasSize.width, roidrawcanvas.canvasSize.height ) //remove all rectangle first

                var rectCount = rects.length
                for( var i=0; i<rectCount; i++ ){
                    var stringList = rects[i].split(";")
                    var sx = stringList[1] //x0
                    var sy = stringList[2]  //y0
                    var w = stringList[3]   //width
                    var h = stringList[4]   //height
                    console.log("x0 = " + sx + " y0 = " + sy + " w = " + w + " h = " + h )
                    ctx.strokeRect( sx, sy, w, h )
                }

                paraOnPaint = 0

            }


        }

        MouseArea{

            id: mouseArea
            anchors.fill: parent

            onPressed: {

                console.log("trigger pressed event");
                console.log("press pos: x = " + mouse.x + " y = " + mouse.y )
                roidrawcanvas.x0 = mouse.x
                roidrawcanvas.y0 = mouse.y

            }

            onReleased: {

                console.log("trigger release event");
                console.log("release pos: x = " + mouse.x + " y = " + mouse.y )
                roidrawcanvas.x1 = mouse.x
                roidrawcanvas.y1 = mouse.y

                window.rectCount = window.rectCount+1
                console.log("rectCount = " + window.rectCount )
                roidrawcanvas.requestPaint()
            }
        }
    }

    Canvas{

        id: gridviewcanvas
        anchors.fill: parent
        enabled: false

        property int divWidth: 0
        property int divHeight: 0
        property real diffWidth: 0
        property real diffHeight: 0
        property int paraOnPaint: 0
        property int x0: 0
        property int y0: 0
        property var flag: []

        onDivHeightChanged: {
            //console.log("divWidth changed to " + divWidth )
            //console.log("divHeight changed to " + divHeight )

            //set flag to note if the rectangle have been pressed, 0 means no , 1 means yes
            for( var i=0; i< divWidth * divHeight; i++ )
                flag.push(0)

            gridviewcanvas.requestPaint()
        }

        onPaint: {

            var ctx = getContext('2d')
            console.log("canvas2 is on paint");
            if( divHeight > 0 && divHeight > 0 && paraOnPaint == 0 ){

                paraOnPaint = 1
                console.log("start to draw line")
                gridviewMouseArea.enabled = true


                ctx.fillStyle = Qt.rgba(128, 128, 128, 0.8 )

                //draw vertical line
                var x_pos = 0
                var y_pos = 0
                diffWidth = gridviewcanvas.canvasSize.width/divWidth
                diffHeight = gridviewcanvas.canvasSize.height/divHeight

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

            }else if( paraOnPaint == 1 ){

                ctx.fillStyle = Qt.rgba(102, 102, 102, 0.3 )
                ctx.fillRect( x0, y0, Math.ceil( diffWidth), Math.ceil( diffHeight )  )

            }else if( paraOnPaint == 2 ){

                ctx.clearRect( 0, 0, canvasSize.width, canvasSize.height )

               //draw vertical line
                x_pos = 0
                y_pos = 0

                for( i=0; i<divWidth-1; i++ ){

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


                var rectCount = window.rects.length
                for(  i=0; i<rectCount; i++ ){

                    var stringList = window.rects[i].split(";")

                    var sx = stringList[1] //x0
                    var sy = stringList[2]  //y0
                    var w = stringList[3]   //width
                    var h = stringList[4]   //height

                    ctx.fillStyle = Qt.rgba(102, 102, 102, 0.3 )
                    ctx.fillRect( sx, sy, w, h  )

                }

                paraOnPaint = 1
            }

        }


        MouseArea{

            id: gridviewMouseArea
            anchors.fill: parent
            enabled: false

            onPressed: {

                window.rectCount +=1

                var x_idx = Math.floor( mouse.x/gridviewcanvas.diffWidth )
                var y_idx = Math.floor( mouse.y/gridviewcanvas.diffHeight )
                var rectIdx = y_idx*gridviewcanvas.divWidth + x_idx
                var newRect = window.rectCount + ";" + x_idx * Math.floor(gridviewcanvas.diffWidth ) + ";" + y_idx * Math.floor(gridviewcanvas.diffHeight ) + ";" + Math.ceil( gridviewcanvas.diffWidth)  + ";" +  Math.ceil( gridviewcanvas.diffHeight);

                if( gridviewcanvas.flag[rectIdx] === 0 ){

                    //console.log("press pos: x = " + mouse.x + " y = " + mouse.y + " idx = " + rectIdx )
                    console.log(newRect)

                     window.rects.push(newRect)

                     gridviewcanvas.x0 = x_idx * Math.floor(gridviewcanvas.diffWidth )
                     gridviewcanvas.y0 = y_idx * Math.floor(gridviewcanvas.diffHeight )

                     gridviewcanvas.requestPaint()

                    //update flag list
                    gridviewcanvas.flag[rectIdx] = 1

                    //update to framefilter
                    window.rectsListSize = window.rectCount

                }

            }
        }
    }

    function listAllRects(){
        var size = window.rects.length
        console.log("in listAllRects")
        for( var i=0; i<size; i++ ){
            console.log( window.rects[i] )
        }
    }

    function removeRectangle( index ){

        if( index < 1 )
            return

        console.log("remove rectangle " + index )
        console.log("before remove")
        listAllRects()

        if( roidrawcanvas.enabled === true ){

            console.log("remove rectangle")
            window.rects.splice( index-1, 1 )

            roidrawcanvas.paraOnPaint = 1
            roidrawcanvas.requestPaint()

        }else if( gridviewcanvas.enabled === true ){

            console.log("remove grid")

            var stringList = window.rects[index-1].split(";")
            var sx = stringList[1]
            var sy = stringList[2]
            var idx = Math.floor( sx/ gridviewcanvas.diffWidth ) +  gridviewcanvas.divWidth * Math.floor( sy/gridviewcanvas.diffHeight )

            gridviewcanvas.flag[idx] = 0
            console.log("paint idx = " + idx)

            window.rects.splice( index-1, 1 )
            gridviewcanvas.paraOnPaint = 2
            gridviewcanvas.requestPaint()

        }

        console.log("after remove rectangle")
        listAllRects()

    }


}
