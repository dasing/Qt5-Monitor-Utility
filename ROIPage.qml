import QtQuick 2.0

Item {
    id: root
    property alias videoview: videoview


//    width: 1400
//    height: 720
    //anchors.fill: parent

    VideoView{

        id: videoview
        anchors.top: parent.top
        anchors.left: parent.left
        chartControl: chartInfo
        controlSpace: roiControlSpace
        cameraSetting: cameraSetting

        width: 640
        height: 480

        filter.onFinished: {
            chartspace.x_result = res.x_result
            chartspace.y_result = res.y_result
        }

    }

    ChartInfo{

        id: chartInfo
        anchors.top: parent.top
        anchors.left: videoview.right
        anchors.leftMargin: 30
        anchors.right: parent.right
        anchors.rightMargin: 50
        visible: false
        canvas: videoview.roicanvas
        chartScope: chartspace
        controlSpace: roiControlSpace

    }

    ChartSpace{

        id: chartspace
        anchors.top: chartInfo.visible ? chartInfo.bottom : parent.top
        anchors.topMargin: 30
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: videoview.right
        anchors.leftMargin: 30
        chartControl: chartInfo
        controlSpace: roiControlSpace

    }

    ROIControlSpace{

        id: roiControlSpace
        anchors.top: videoview.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        drawcanvas: videoview.roicanvas.roidrawcanvas
        gridviewcanvas: videoview.roicanvas.gridviewcanvas


        roiButton.onClicked: {

            rectangleROI.visible = true
            gridviewROI.visible = true
            reset.visible = true
            chartInfo.visible = true

        }


    }

}
