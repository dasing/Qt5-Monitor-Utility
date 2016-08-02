import QtQuick 2.0
import QtMultimedia 5.5
import qmlvideofilter 1.0
//import qmlroicanvas 1.0

Rectangle {

    property alias filter: filter

    ROICanvas{

        id: roicanvas



    }

//    Divider{
//        id: divider
//        visible: true
//        z: 1.0
//        //onValueChanged: updateDivider()

//    }


    FrameFilter{

        id:filter
        /*range parameter*/
        property int x_start: -1
        property int x_end: -1
        property int y_start: -1
        property int y_end: -1

        onX_startChanged: {
            console.log("x_start change successfully to " + x_start );
            filter.setX_start(x_start);
            console.log("camera resolrtion = " + camera.viewfinder.resolution );

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
