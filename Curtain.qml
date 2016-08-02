import QtQuick 2.0

Rectangle {

    id: root
    color: "transparent"
    radius: 5
    property alias value: grip.value
    property color gripColor: "transparent"
    property real gripSize: 20
    property real gripTolerance: 3.0
    property real increment: 0.1
    property bool enabled: true
    property string imageSource: "qrc:/Slider_handle.png"

    Rectangle{
        id: grip
        property real value: 0.5
        x: (value*parent.width) - width/2
        anchors.verticalCenter: parent.verticalCenter
        width: root.gripTolerance * root.gripSize
        height: width
        radius: width/2
        color: "transparent"

        Image{
            id:sliderhandleimage
            source: imageSource
            anchors.centerIn: parent
        }

        MouseArea{
            id: mouseArea
            enabled: root.enabled
            anchors.fill: parent
            drag{
                target: grip
                axis: Drag.XAxis
                minimumX: -parent.width/2
                maximumX: root.width - parent.width/2
            }

            onPositionChanged: {
                if( drag.active )
                    updatePosition()
            }

            onReleased: {
                updatePosition()
            }

            function updatePosition(){
                value = ( grip.x + grip.width /2 ) / grip.parent.width
            }
        }


    }
}
