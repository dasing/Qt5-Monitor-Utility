import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import qmlbcvdecoder 1.0

Item {

        width: 1000
        height: 700
        SystemPalette { id: palette }
        clip: true

        FileDialog {
            id: fileDialog
            visible: false
            modality: Qt.WindowModal
            title: "Choose a file"
            selectExisting: true
            selectMultiple: false
            selectFolder: false
            nameFilters: [ "(*.bcv)" ]
            selectedNameFilter: "(*.bcv)"

            onFileUrlChanged: {
                decoder.decodeFile(fileUrl)

            }
        }


       ColumnLayout {

               id: fileChooser
               anchors {
                   left: parent.left
                   right: parent.right
                   top: parent.top
                   leftMargin: 12
               }

               spacing: 8
               //Item { Layout.preferredHeight: 4 } // padding

               Label {
                    text: "<b>chosen files:</b> " + fileDialog.fileUrls
               }

               Button {
                   id: button

                   text: "Find"
                   onClicked: {
                       fileDialog.visible = true
                       fileDialog.open()
                   }
               }


               Rectangle{

                   id: fileInfo
                   border.color: "#c8cccf"
                   radius: 8

                   property int version: 0
                   property int videoWidth: 0
                   property int videoHeight: 0
                   property double fps: 0
                   property string pixFormat: ""
                   property int totalFrame: 0
                   property int year: 0
                   property int mon: 0
                   property int day: 0
                   property int hour: 0
                   property int min: 0
                   property int sec: 0
                   property string camName: ""
                   property string nirBaseline: ""
                   property string channel: ""
                   width: parent.width
                   height: 220


                   ColumnLayout{

                       anchors.top: parent.top
                       anchors.left: parent.left
                       anchors.topMargin: 12
                       anchors.leftMargin: 12
                       spacing: 2

                       Label{
                           text: "File Information: "

                       }

                       Label{
                           text: "Version " + fileInfo.version
                       }

                       Label{
                           text: "Width " + fileInfo.videoWidth
                       }

                       Label{
                           text: "Height " + fileInfo.videoHeight
                       }

                       Label{
                           text: "Fps " + fileInfo.fps
                       }

                       Label{
                           text: "Pixel Format " + fileInfo.pixFormat
                       }

                       Label{
                           text: "Total Frames " + fileInfo.totalFrame
                       }

                       Label{
                           text: "Time " + fileInfo.year + "/" + fileInfo.mon + "/" + fileInfo.day + " " + fileInfo.hour + ":" + fileInfo.min + ":" + fileInfo.sec
                       }

                       Label{
                           text: "Camera Name " + fileInfo.camName
                       }

                       Label{
                           text: "Nir Baseline " + fileInfo.nirBaseline
                       }

                       Label{
                           text: "Nir Channels " + fileInfo.channel
                       }

                   }

               }
        }


        BCVDecoder{
            id: decoder
            onSendVideoHeaderInfo: {
                console.log("receive video header" + videoHeaderStruct )
                var infos = videoHeaderStruct.split(";")
                fileInfo.version = infos[0]
                fileInfo.videoWidth = infos[1]
                fileInfo.videoHeight = infos[2]
                fileInfo.fps = infos[3]
                fileInfo.pixFormat = "RGBA8888"
                fileInfo.totalFrame = infos[5]
                fileInfo.year = infos[6]
                fileInfo.mon = infos[7]
                fileInfo.day = infos[8]
                fileInfo.hour = infos[9]
                fileInfo.min = infos[10]
                fileInfo.sec = infos[11]
                fileInfo.camName = infos[12]
                fileInfo.nirBaseline = infos[13]
                fileInfo.channel = infos[14]

            }

            onSendFrameHeaderInfo:{
                console.log("receive frame header" + frameHeaderStruct )
                var infos = frameHeaderStruct.split(";")
                var index = infos[0]
                var hr_bpm = infos[1]
                var rr_bpm = infos[2]
                var interval = infos[3]
                var lambda = infos[4]
                var eb_ts = infos[5]

//                console.log("index = " + index )
//                console.log("hr_bpm = " + hr_bpm )
//                console.log("rr_bpm = " + rr_bpm )
//                console.log("lambda = " + lambda )
//                console.log("interval = " + interval )
//                console.log("eb_ts = " + eb_ts )
                  photoGallery.frameModel.append( { "index": index, "hr_bpm": hr_bpm, "rr_bpm": rr_bpm, "interval": interval, "lambda": lambda, "eb_ts": eb_ts } )
            }

            onSendImage: {
                ProviderImg.carryImage( image );
            }
        }


        Rectangle{

            id: fileScrollView
            anchors.top: fileChooser.bottom
            anchors.topMargin: 30
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 12
            anchors.right: parent.right

            Gallery{
                id: photoGallery

            }

        }

}
