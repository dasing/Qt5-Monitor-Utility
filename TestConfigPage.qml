import QtQuick 2.0

Item {
    Rectangle{
        id: previewSpace
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 30
        width: 640
        height: 480
        color: "black"
    }

    Rectangle{
        id: controlSpace
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.left: previewSpace.right
        anchors.leftMargin: 15
        width: 400
        height: 480
        color: "pink"

    }


}
