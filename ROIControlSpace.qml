import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4



RowLayout {


    id: roiControl

    //alias
    property alias roiControl: roiControl
    property alias roiButton: roiButton
    property alias rectangleROI: rectangleROI
    property alias gridviewROI: gridviewROI
    property alias reset: reset
    property alias quit: quit

    //var
    property var drawcanvas: null
    property var gridviewcanvas: null

    Button{

        id: roiButton
        anchors.left: parent.left
        anchors.leftMargin: 10
        text: "DO ROI"
        style: ButtonStyle {
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 25
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888"
                    radius: 4
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                        GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                    }
                }
         }



    }

    Button{
        id: rectangleROI
        anchors.left: roiButton.right
        anchors.leftMargin: 10
        text: "Draw Rectangle"
        visible: false
        style: ButtonStyle {
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 25
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888"
                    radius: 4
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                        GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                    }
                }
         }

        onClicked: {
            drawcanvas.enabled = true
        }

    }

    Button{

        id: gridviewROI
        anchors.left: rectangleROI.right
        anchors.leftMargin: 10
        text: "Grid View"
        visible: false
        style: ButtonStyle {
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 25
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888"
                    radius: 4
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                        GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                    }
                }
         }

         onClicked:{
             gridviewroiControlSpace.visible = true
             gridviewcanvas.enabled = true

         }

    }

    Rectangle{

        id: gridviewroiControlSpace
        visible: false
        anchors.top: gridviewROI.bottom
        anchors.left: gridviewROI.left

        Text{
            id: widthText
            text: "Width: "
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left

        }

        TextField{
            id: divWidth
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: widthText.right
            placeholderText: "2-20"
        }

        Text{
            id: heightText
            text: "Height:"
            anchors.top: divWidth.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
        }

        TextField{
            id: divHeight
            anchors.top: divWidth.bottom
            anchors.topMargin: 10
            anchors.left: heightText.right
            placeholderText: "2-20"
        }

        Button{
            id: confirmbutton
            anchors.left: divHeight.right
            anchors.leftMargin: 10
            anchors.top: divHeight.top
            text: "OK"

            onClicked: {
                var width = divWidth.text
                var height = divHeight.text
                gridviewcanvas.divWidth = width
                gridviewcanvas.divHeight = height
                console.log("width = " + width +" height = " + height )
            }
        }

    }



    Button{
        id: reset
        anchors.left: gridviewROI.right
        anchors.leftMargin: 10
        text :"Reset"
        visible: false

        style: ButtonStyle {
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 25
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888"
                    radius: 4
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                        GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                    }
                }
         }



    }

    Button{
        id: quit
        anchors.left: reset.right
        anchors.leftMargin: 10
        text: "Quit"
        visible: false

        style: ButtonStyle {
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 25
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888"
                    radius: 4
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                        GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                    }
                }
         }

    }






}
