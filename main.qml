import QtQuick 2.0

Item {
    id: root
    width: 1400
    height: 720

    Location{

        id: location
        anchors.left: menu.right
        anchors.top: parent.top
        anchors.right: parent.right
        height: menu.logoHeight

    }


    MenuBar{

        id: menu
        anchors.left: root.left
        anchors.top: root.top
        anchors.bottom: root.bottom
        menubarWidth: 230
        menubarHeight: root.height

    }


    VideoView{

        id: videoview
        anchors.top: location.bottom
        anchors.topMargin: 50
        //anchors.bottom: parent.bottom
        anchors.left: menu.right
        anchors.leftMargin: 30
        //anchors.right: chartspace.left
        //anchors.rightMargin: 0
        chartControl: chartInfo
        controlSpace: roiControlSpace

        width: 640
        height: 480

        filter.onFinished: {
            chartspace.x_result = res.x_result
            chartspace.y_result = res.y_result
        }

    }

    ChartInfo{

        id: chartInfo
        anchors.top: location.bottom
        anchors.topMargin: 50
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
        anchors.top: chartInfo.visible ? chartInfo.bottom : location.bottom
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
        anchors.left: menu.right
        drawcanvas: videoview.roicanvas.roidrawcanvas
        gridviewcanvas: videoview.roicanvas.gridviewcanvas


        roiButton.onClicked: {
            console.log("clicked ROI")

            rectangleROI.visible = true
            gridviewROI.visible = true
            reset.visible = true
            //quit.visible = true
            chartInfo.visible = true

        }


    }

}
