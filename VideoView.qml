import QtQuick 2.0
import QtMultimedia 5.5
import qmlvideofilter 1.0


Rectangle {

    id: window
    property alias filter: filter
    property alias roicanvas: roicanvas
    property var chartControl: null
    property var controlSpace: null
    property var cameraSetting: null
    property var cameraId


    Component.onCompleted: {

        chartControl.deleteSeries.connect( function( index ){
            //console.log("VideoView receive delete signal from chartInfo, index is " + index )
            roicanvas.removeRectangle( index )
            filter.removeData( index )
        })

        controlSpace.resetROI.connect( function(){
            roicanvas.clearData()
            filter.clearData()
        })

        cameraSetting.changeCamera.connect( function( cameraID ){
            camera.deviceId = cameraID
        })



    }

    ROICanvas{

        id: roicanvas
        onRectsListSizeChanged: {
            filter.updateFlag = 1
        }

    }


    FrameFilter{


        id:filter

        property int updateFlag : 0 // 1 means has new thing to update, 0 means nothing to update

        onUpdateFlagChanged: {

            console.log("uddate flag change")

            if( updateFlag == 1 ){

                console.log("update list in frame filter")
                //filter.updateAreaList( roicanvas.arealist.areaList )
                //console.log("in update flag change, areaList size = " + roicanvas.arealist.areaList.count() )
                //console.log( roicanvas.arealist.areaList )

                rectList = roicanvas.rects
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


        onDeviceIdChanged: console.log("deviceID change to " + deviceId )

    }

    VideoOutput{

        anchors.fill: parent
        source: camera
        filters: [ filter ]

    }




}
