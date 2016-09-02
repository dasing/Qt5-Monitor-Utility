import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import qmlbcvdecoder 1.0

Item {

        width: 580
        height: 400
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
                console.log("here!")
                decoder.decodeFile(fileUrl)

            }
        }

        ScrollView {

               id: scrollView
               anchors {
                   left: parent.left
                   right: parent.right
                   top: parent.top
                   leftMargin: 12
               }


               ColumnLayout {

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
        }

        Rectangle{

            id: fileScrollView
            anchors.top: scrollView.bottom
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 30

            RowLayout{

                spacing: 8

                Gallery{
                    id: photoGallery
                }

                Rectangle{

                    id: fileInfo

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
                    width: 300
                    height: 900
                    color: "red"

                    ColumnLayout{

                        spacing: 2
                        //anchors.fill: parent

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

        }




}
