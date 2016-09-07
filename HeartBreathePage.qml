import QtQuick 2.0
import QtMultimedia 5.6
import qmlbcvencoder 1.0
import QtQuick.Controls 1.4


Item {


    property alias bcvEncoder: bcvencoder



    Rectangle{

        //background of CameraVideoOutput
        id: cameraSpace

        anchors.left: parent.left
        anchors.top: parent.top
        color: "transparent"

        width: 640
        height: 480


        BCVEncoder{
            id: bcvencoder
            active: false

        }

    }

   Button{
       id: startButton
       text: "Start"
       anchors.left: parent.left
       anchors.top: cameraSpace.bottom
       onClicked: {
           bcvencoder.active = true
           bcvencoder.initializeBCVEncoder();

       }
   }

   Button{
       id: stopButton
       text: "Stop"
       anchors.left: startButton.right
       anchors.top: cameraSpace.bottom
       onClicked: {
           bcvencoder.active = false
           bcvencoder.resetBCVEncoder()
       }
   }

//   Text{
//       id: frameNumber
//       text: bcvencoder.totalFrame
//   }

//    ChartSpace{

//    }
}
