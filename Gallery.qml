import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1

Rectangle{

    property alias frameInfoModel: frameInfoModel
    property int frameNumber: 0
    property int index: 0
    property int activeFlag: 0
    property double fps: 30.0
    property double deltaTime: 1/fps;
    color: "cornsilk"

    anchors.fill: parent

    onActiveFlagChanged: {
        //activate preview
        img.source = "image://provider/" + index.toString()

    }

    ListModel{
        id: frameInfoModel
    }


    Image{
        id: img
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 12
        source: "qrc:/image/BCVPreviewerDefaultImg.png"
    }

    Rectangle{

        id: frameInfo
        color: "pink"
        anchors.top: parent.top
        anchors.left: img.right
        anchors.leftMargin: 12
        width: 150
        height: 200

        Column{

            anchors.fill: parent
            Text{ text: "Frame Info: "}
            Text{ text: ' index = ' + frameInfoModel.get(index).index }
            Text{ text: ' hr_bpm = ' + frameInfoModel.get(index).hr_bpm }
            Text{ text: ' rr_bpm = ' + frameInfoModel.get(index).rr_bpm }
            Text{ text: ' interval = ' + frameInfoModel.get(index).interval }
            Text{ text: ' lambda = ' + frameInfoModel.get(index).lambda }
            Text{ text: ' eb_ts = ' + frameInfoModel.get(index).eb_ts }
        }

    }



    Slider{
        id: slider
        anchors.top: img.bottom
        anchors.topMargin: 12
        anchors.left: parent.left
        anchors.leftMargin: 12
        maximumValue: frameNumber == 0 ? 0 : frameNumber-1
        stepSize: 1.0
        value: 0

        onValueChanged: {

            index = slider.value
            img.source = "image://provider/" + index.toString()

        }
    }

    // ------ Control Space ------ //
    RowLayout{

        anchors.top: slider.bottom
        anchors.left: parent.left
        anchors.leftMargin: 12

        Button{
            id: play

            style: ButtonStyle{
                background: Rectangle{

                    implicitHeight: 40
                    implicitWidth: 40
                    color: "transparent"

                    Image{
                        anchors.fill: parent
                        source: "qrc:/image/play.png"
                    }
                }

            }

            PropertyAnimation { id: playAnimation; target: slider; property: "value"; to: frameNumber  }

            onClicked: {
//                console.log("deltaTime = " + deltaTime )
//                console.log("duration = " + (frameNumber-1-slider.value)*deltaTime*1000 )
                playAnimation.duration = (frameNumber-1-slider.value)*deltaTime*1000
                playAnimation.start()
            }

        }


        Button{
            id: stop

            style: ButtonStyle{
                background: Rectangle{

                    implicitHeight: 40
                    implicitWidth: 40
                    color: "transparent"

                    Image{
                        anchors.fill: parent
                        source: "qrc:/image/stop.png"
                    }
                }

            }

            onClicked: playAnimation.stop()
        }

        Button{
            id: forward

            style: ButtonStyle{
                background: Rectangle{

                    implicitHeight: 40
                    implicitWidth: 40
                    color: "transparent"

                    Image{
                        anchors.fill: parent
                        source: "qrc:/image/forward.png"
                    }
                }

            }

            onClicked: {
                slider.value += 1
            }

        }

        Button{
            id: backward
            style: ButtonStyle{
                background: Rectangle{

                    implicitHeight: 40
                    implicitWidth: 40
                    color: "transparent"

                    Image{
                        anchors.fill: parent
                        source: "qrc:/image/backward.png"
                    }
                }

            }

            onClicked: {
                slider.value -= 1
            }
        }


    }


}

//ScrollView {

//    property alias frameModel: frameModel
//    anchors.fill: parent
//    frameVisible: true

//    ListView{
//        anchors.fill: parent
//        spacing: 10
//        id: frameListView
//        model: frameModel
//        delegate: frameDelegate
//        flickableDirection: Flickable.VerticalFlick
//        boundsBehavior: Flickable.StopAtBounds

//        ListModel{
//            id: frameModel
//        }

//        Component{
//            id: frameDelegate
//            Rectangle{

//                width: parent.width
//                height: 500

//                RowLayout{

//                    anchors.top: parent.top
//                    anchors.topMargin: 10
//                    anchors.left: parent.left
//                    anchors.leftMargin: 10
//                    spacing: 50

//                    Column{
//                        Text{ text: ' index = ' + index }
//                        Text{ text: ' hr_bpm = ' + hr_bpm }
//                        Text{ text: ' rr_bpm = ' + rr_bpm }
//                        Text{ text: ' interval = ' + interval }
//                        Text{ text: ' lambda = ' + lambda }
//                        Text{ text: ' eb_ts = ' + eb_ts }
//                    }

//                    Image{ source: "image://provider/" + index.toString() }

//                }

//            }
//        }


//    }

//    style: ScrollViewStyle{

//         transientScrollBars: true
//         handle: Item {
//             implicitWidth: 14
//             implicitHeight: 26
//             Rectangle {
//                 color: "#424246"
//                 anchors.fill: parent
//                 anchors.topMargin: 6
//                 anchors.leftMargin: 4
//                 anchors.rightMargin: 4
//                 anchors.bottomMargin: 6
//             }
//         }

//         scrollBarBackground: Item {
//             implicitWidth: 14
//             implicitHeight: 26
//         }

//    }


//}
