import QtQuick 2.0

Item {

    id: root
    width: 1400
    height: 800
    state: "ROI"

    //menu bar
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
        onCurrPageChanged: {
            root.state = currPage
        }

    }

    onStateChanged: {
        console.log("curr state = " + state )

    }

    CameraVideoOutput{
        id: cameraOutput
        anchors.left: menu.right
        anchors.top: location.bottom
        anchors.leftMargin: 30
        anchors.topMargin: 30
        cameraSetting: settingPage
        width: 640
        height: 480
        visible: true
        videoOutput.filters: [ heartBreathePage.bcvEncoder, roiPage.videoview.frameFilter ]
    }


    //page
    SettingPage{
        id: settingPage
        anchors.left: menu.right
        anchors.leftMargin: 30
        anchors.top: location.bottom
        anchors.topMargin: 30
        visible: false
        //cameraID: roiPage.videoview.cameraId
        //onCameraIDChanged: { console.log("cameraID changed to " + cameraID ) }
    }

    HeartBreathePage{
        id: heartBreathePage
        anchors.left: menu.right
        anchors.leftMargin: 30
        anchors.top: location.bottom
        anchors.topMargin: 30
        visible: false


    }

    ROIPage{

        id: roiPage
        anchors.left: menu.right
        anchors.leftMargin: 30
        anchors.top: location.bottom
        anchors.topMargin: 30
        visible: false
        videoview.cameraSetting: settingPage


    }

    TestConfigPage{
        id: testconfigPage
        anchors.left: menu.right
        anchors.leftMargin: 30
        anchors.top: location.bottom
        anchors.topMargin: 30
        visible: false

    }

    SystemFunctionPage{
        id: systemFunctionPage
        anchors.left: menu.right
        anchors.leftMargin: 30
        anchors.top: location.bottom
        anchors.topMargin: 30
        visible: false
    }

    CameraTestPage{
        id: cameraTestPage
        anchors.left: menu.right
        anchors.leftMargin: 30
        anchors.top: location.bottom
        anchors.topMargin: 30
        visible: false
    }

    LoadFilePage{
        id: loadFilePage
        anchors.left: menu.right
        anchors.leftMargin: 30
        anchors.top: location.bottom
        anchors.topMargin: 30
        visible: false
    }

    states:[

        State{
            name: "Settings"
            PropertyChanges {  target: settingPage; visible: true }
            PropertyChanges {  target: heartBreathePage; visible: false }
            PropertyChanges {  target: roiPage; visible: false }
            PropertyChanges {  target: testconfigPage; visible: false }
            PropertyChanges {  target: systemFunctionPage; visible: false }
            PropertyChanges {  target: cameraTestPage; visible: false }
            PropertyChanges {  target: loadFilePage; visible: false }
            PropertyChanges {  target: cameraOutput; visible: false }
        },
        State{
            name: "HeartBeat and Breathe"
            PropertyChanges {  target: settingPage; visible: false }
            PropertyChanges {  target: heartBreathePage; visible: true }
            PropertyChanges {  target: roiPage; visible: false }
            PropertyChanges {  target: testconfigPage; visible: false }
            PropertyChanges {  target: systemFunctionPage; visible: false }
            PropertyChanges {  target: cameraTestPage; visible: false }
            PropertyChanges {  target: loadFilePage; visible: false }
            PropertyChanges {  target: cameraOutput; visible: true }

        },
        State{
            name: "ROI"
            PropertyChanges {  target: settingPage; visible: false }
            PropertyChanges {  target: heartBreathePage; visible: false }
            PropertyChanges {  target: roiPage; visible: true }
            PropertyChanges {  target: testconfigPage; visible: false }
            PropertyChanges {  target: systemFunctionPage; visible: false }
            PropertyChanges {  target: cameraTestPage; visible: false }
            PropertyChanges {  target: loadFilePage; visible: false }
            PropertyChanges {  target: cameraOutput; visible: true }

        },
        State{
            name: "Testing Config"
            PropertyChanges {  target: settingPage; visible: false }
            PropertyChanges {  target: heartBreathePage; visible: false }
            PropertyChanges {  target: roiPage; visible: false }
            PropertyChanges {  target: testconfigPage; visible: true }
            PropertyChanges {  target: systemFunctionPage; visible: false }
            PropertyChanges {  target: cameraTestPage; visible: false }
            PropertyChanges {  target: loadFilePage; visible: false }
            PropertyChanges {  target: cameraOutput; visible: false }

        },
        State{
            name: "System Function Testing"
            PropertyChanges {  target: settingPage; visible: false }
            PropertyChanges {  target: heartBreathePage; visible: false }
            PropertyChanges {  target: roiPage; visible: false }
            PropertyChanges {  target: testconfigPage; visible: false }
            PropertyChanges {  target: systemFunctionPage; visible: true }
            PropertyChanges {  target: cameraTestPage; visible: false }
            PropertyChanges {  target: loadFilePage; visible: false }
            PropertyChanges {  target: cameraOutput; visible: false }

        },
        State{
            name: "Camera Testing"
            PropertyChanges {  target: settingPage; visible: false }
            PropertyChanges {  target: heartBreathePage; visible: false }
            PropertyChanges {  target: roiPage; visible: false }
            PropertyChanges {  target: testconfigPage; visible: false }
            PropertyChanges {  target: systemFunctionPage; visible: false }
            PropertyChanges {  target: cameraTestPage; visible: true }
            PropertyChanges {  target: loadFilePage; visible: false }
            PropertyChanges {  target: cameraOutput; visible: false }

        },

        State{
            name: "Load File"
            PropertyChanges {  target: settingPage; visible: false }
            PropertyChanges {  target: heartBreathePage; visible: false }
            PropertyChanges {  target: roiPage; visible: false }
            PropertyChanges {  target: testconfigPage; visible: false }
            PropertyChanges {  target: systemFunctionPage; visible: false }
            PropertyChanges {  target: cameraTestPage; visible: false }
            PropertyChanges {  target: loadFilePage; visible: true }
            PropertyChanges {  target: cameraOutput; visible: false }

        }


    ]


}
