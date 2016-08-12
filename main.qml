import QtQuick 2.0

Item {
    id: root
    width: 1300
    height: 720

    VideoView{

        id: videoview
        anchors.top: parent.top
        anchors.topMargin: 50
        //anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 50
        //anchors.right: chartspace.left
        //anchors.rightMargin: 0
        chartControl: chartInfo

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
        anchors.topMargin: 50
        anchors.left: videoview.right
        anchors.leftMargin: 50
        anchors.right: parent.right
        anchors.rightMargin: 50
        visible: false
        canvas: videoview.roicanvas
        chartScope: chartspace



    }

    ChartSpace{

        id: chartspace
        anchors.top: chartInfo.visible ? chartInfo.bottom : parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: videoview.right
        anchors.leftMargin: 50
        chartControl: chartInfo


    }

    ROIControlSpace{

        id: roiControlSpace
        anchors.top: videoview.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        drawcanvas: videoview.roicanvas.roidrawcanvas
        gridviewcanvas: videoview.roicanvas.gridviewcanvas


        roiButton.onClicked: {
            console.log("clicked ROI")

            rectangleROI.visible = true
            gridviewROI.visible = true
            reset.visible = true
            quit.visible = true
            chartInfo.visible = true

        }


    }

}
