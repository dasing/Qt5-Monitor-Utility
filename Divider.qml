import QtQuick 2.0

Rectangle {

    id: root
    anchors.fill: parent
    color: "transparent"
    property alias value: topSlider.value
    //property alias horizontalValue: leftSlider.value
    property alias lineWidth: line.width
    property alias gripSize: topSlider.gripSize

    Rectangle{
        id: line
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        //anchors.left: parent.left
        x : parent.value * parent.width - (width/2)
        width: 4
        color: "#14aaff"
    }


    Curtain{
        id: topSlider
        increment: 0.0
        anchors{
            top: parent.top
            topMargin: (gripSize/2 ) +5
            left: parent.left
            right: parent.right
        }

        onValueChanged: bottomSlider.value = topSlider.value
    }

    Curtain{
        id: bottomSlider
        increment: 0.0
        anchors{
            bottom: parent.bottom
            bottomMargin: (gripSize/2) +5
            left: parent.left
            right: parent.right
        }

        onValueChanged: topSlider.value = bottomSlider.value
    }

//    Curtain{
//        id: leftSlider
//        increment: 0.0
//        anchors{
//            top: parent.top
//            bottom: parent.bottom
//            left: parent.left
//            leftMargin: (gripSize/2) +5
//        }

//        onValueChanged: rightSlider.value = leftSlider.value
//    }

//    Curtain{
//        id: rightSlider
//        increment: 0.0
//        anchors{
//            top: parent.top
//            bottom: parent.bottom
//            right: parent.right
//            rightMargin: (gripSize/2) +5
//        }

//        onValueChanged: leftSlider.value = rightSlider.value
//    }


}
