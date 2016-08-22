import QtQuick 2.0

ListModel {

    id: listItems

    ListElement{
        name: "Settings"
        imgSource: "qrc:/image/settings_red.png"
        hoveredSource: "qrc:/image/settings_white.png"
        index: 0
    }

    ListElement{
        name: "HeartBeat and Breathe"
        imgSource: "qrc:/image/frequency_red.png"
        hoveredSource: "qrc:/image/frequency_white.png"
        index: 1
    }

    ListElement{
        name: "ROI"
        imgSource: "qrc:/image/square_red.png"
        hoveredSource: "qrc:/image/square_white.png"
        index: 2
    }

    ListElement{
        name: "Testing Config"
        imgSource: "qrc:/image/window_red.png"
        hoveredSource: "qrc:/image/window_white.png"
        index: 3
    }

    ListElement{
        name: "System Function Testing"
        imgSource: "qrc:/image/computer_red.png"
        hoveredSource: "qrc:/image/computer_white.png"
        index: 4
    }

    ListElement{
        name: "Camera Testing"
        imgSource: "qrc:/image/camera_red.png"
        hoveredSource: "qrc:/image/camera_white.png"
        index: 5
    }
}
