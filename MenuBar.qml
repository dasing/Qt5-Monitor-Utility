import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0

ColumnLayout{

    property int menubarWidth: 0
    property int menubarHeight: 0
    property int iconWidth: 50
    property int logoHeight: 60

    anchors.left: parent.left
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    spacing: 0

    Rectangle{

        id: logo
        color: "#efa1af"
        implicitHeight: logoHeight
        implicitWidth: menubarWidth

        Image{
            width: logo.implicitWidth
            height: 35
            fillMode: Image.PreserveAspectFit
            source: "qrc:/image/logo.png"
            anchors.centerIn: parent
        }
    }

    RowLayout{

        id: menuBarList
        spacing: 0

        Rectangle{

            id: iconList
            implicitHeight: menubarHeight
            implicitWidth: iconWidth
            color: "#efa1af"
        }

        Rectangle{

            id: textList
            implicitHeight: menubarHeight
            implicitWidth: menubarWidth - iconWidth
            color: "#fcd1d3"

        }


        ListView{

            id: listView
            anchors.fill: parent
            spacing: 10
            model: MenuBarList {}
            delegate: menuitemdelegate

            Component{

                id: menuitemdelegate

                Button{
                    id: menuitem

                    style: ButtonStyle{

                        background: Rectangle{
                            color: control.hovered ? "#e55175" : "transparent"
                        }

                        label: RowLayout{

                            Rectangle{

                                id: icon
                                implicitHeight: 25
                                implicitWidth: 25
                                anchors.left: parent.left
                                anchors.leftMargin: 8
                                color: "transparent"

                                Image{

                                    anchors.fill: parent
                                    source: control.hovered ? hoveredSource : imgSource
                                }

                            }

                            Rectangle{

                                implicitWidth: menubarWidth - iconWidth + 12
                                implicitHeight: 18
                                color: "transparent"
                                anchors.left: icon.right
                                anchors.leftMargin: 25

                                Text{
                                    text: name
                                    color: control.hovered ? "#ffffff" : "#000000"
                                    font.family: "sans-serif"
                                }

                            }


                        }
                    }

                }

            }

        }

    }


}



