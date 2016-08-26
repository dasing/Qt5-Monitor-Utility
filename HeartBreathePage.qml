import QtQuick 2.0
import QtMultimedia 5.6
import qmlbcvencoder 1.0
import QtQuick.Controls 1.4


Item {

    property var cameraSetting
    Component.onCompleted: {
        cameraSetting.changeCamera.connect( function( cameraID ){
            camera2.deviceId = cameraID
        })
    }

    Rectangle{

        /*Maybe this Rectangle can be combined by VideoView.qml*/

        id: cameraSpace

        anchors.left: parent.left
        anchors.top: parent.top
        color: "red"

        width: 640
        height: 480


        BCVEncoder{
            id: bcvencoder
            active: false

        }

        //    MediaPlayer {
        //           id: player
        //           source: "qrc:/test.mp4"
        //           autoPlay: true
        //   }

        Camera{

            id: camera2
            //captureMode: Camera.CaptureVideo
            viewfinder.resolution: Qt.size( 640, 480 );
            property int resolutionWidth: viewfinder.resolution.width

            onResolutionWidthChanged: {
                //console.log("camera2 resolutionWdith chagned to " + resolutionWidth )
                viewfinder.resolution = Qt.size( 640, 480 )
            }

            //onDeviceIdChanged: console.log("deviceID change to " + deviceId )

        }

       VideoOutput {
           id: videoOutput
           source: camera2
           anchors.fill: parent
           filters: [ bcvencoder ]
       }

    }

   Button{
       id: startButton
       text: "Start"
       anchors.left: parent.left
       anchors.top: cameraSpace.bottom
       onClicked: bcvencoder.active = true
   }

   Button{
       id: stopButton
       text: "Stop"
       anchors.left: startButton.right
       anchors.top: cameraSpace.bottom
       onClicked: bcvencoder.active = false
   }

//    ChartSpace{

//    }
}
