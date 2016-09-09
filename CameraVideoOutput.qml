import QtQuick 2.0
import QtMultimedia 5.5

Rectangle{


    color: "black"
    property alias videoOutput: videoOutput
    property var cameraSetting

    Component.onCompleted: {

        cameraSetting.changeCamera.connect( function( cameraID ){
            camera.deviceId = cameraID
        })

    }



    VideoOutput{

        id: videoOutput
        anchors.fill: parent
        source: camera
        //filters: [ filter ]


        Camera{

            id: camera
            //captureMode: Camera.CaptureVideo

            property int resolutionWidth: viewfinder.resolution.width

            Component.onCompleted:  {
                viewfinder.resolution = Qt.size( 640, 480 );
                viewfinder.minimumFrameRate = 30;
            }
            onDeviceIdChanged: {

                viewfinder.resolution = Qt.size( 640, 480 )
                console.log("deviceID change to " + deviceId )
            }

            onResolutionWidthChanged: {
                viewfinder.resolution = Qt.size( 640, 480 )
            }

        }

    }

}






