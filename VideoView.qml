import QtQuick 2.0
import QtMultimedia 5.5
import qmlvideofilter 1.0
//import qmlroicanvas 1.0

Rectangle {

    id: window
    property alias filter: filter
    property alias roicanvas: roicanvas

    ROICanvas{

        id: roicanvas
        onRectsListSizeChanged: {
            filter.updateFlag = 1
        }

    }


    FrameFilter{


        id:filter

        /*range parameter*/
        property int x_start: -1
        property int x_end: -1
        property int y_start: -1
        property int y_end: -1
        property int updateFlag : 0 // 1 means has new thing to update, 0 means nothing to update

//        onX_startChanged: {
//            console.log("x_start change successfully to " + x_start );
//            filter.setX_start(x_start);
//            console.log("camera resolrtion = " + camera.viewfinder.resolution );

//        }

        onUpdateFlagChanged: {

            console.log("uddate flag change")

            if( updateFlag == 1 ){

                console.log("update list in frame filter")
                //filter.updateAreaList( roicanvas.arealist.areaList )
                //console.log("in update flag change, areaList size = " + roicanvas.arealist.areaList.count() )
                //console.log( roicanvas.arealist.areaList )

                rectList = roicanvas.rects
                //filter.addRect("222")
                filter.listRectList()

                updateFlag = 0

            }

        }

        /*onFinished() is in main.qml*/

    }

    Camera{

        id: camera
        captureMode: Camera.CaptureVideo
        viewfinder.resolution: Qt.size( 640, 480 );

    }

    VideoOutput{

        anchors.fill: parent
        source: camera
        filters: [ filter ]

    }




}
