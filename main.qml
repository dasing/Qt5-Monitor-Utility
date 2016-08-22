import QtQuick 2.0

Item {

    id: root
    width: 1400
    height: 720


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

    }


    SettingPage{
        id: settingPage
        visible: false
    }

    HeartBreathePage{
        id: heartBreathePage
        visible: false
    }

    ROIPage{
        id: roiPage
        anchors.fill: parent
        visible: false
    }

    TestConfigPage{
        id: testconfigPage
        visible: false

    }

    SystemFunctionPage{
        id: systemFunctionPage
        visible: false
    }

    CameraTestPage{
        id: cameraTestPage
        visible: false
    }


}
