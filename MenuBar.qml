import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0

ColumnLayout{

    property int menubarWidth: 0
    property int menubarHeight: 0
    property int iconWidth: 50
    property int logoHeight: 60
    property string currPage

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
            property int defaultPageIndex: 2
            property string defaultPageHoveredSource: "qrc:/image/square_white.png"
            property color defaultTextColor: "#000000"
            property color hoveredTextColor: "#ffffff"
            property color pressedTextColor: "#ffffff"
            property color hoveredBackgroundColor: "#e55175"

            Component.onCompleted: {

                //default page is ROI
                listView.currentIndex = defaultPageIndex
                listView.currentItem.backgroundColor = hoveredBackgroundColor
                listView.currentItem.textColor = pressedTextColor
                listView.currentItem.iconColor = defaultPageHoveredSource
            }

            Component{

                id: menuitemdelegate

                Button{
                    id: menuitem
                    property color backgroundColor: hovered ? listView.hoveredBackgroundColor : "transparent"
                    property color textColor: hovered ? listView.hoveredTextColor : listView.defaultTextColor
                    property string iconColor: hovered ? hoveredSource : imgSource


                    style: ButtonStyle{

                        background: Rectangle{
                            id: bgRect
                            color: menuitem.backgroundColor

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
                                    source: menuitem.iconColor
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
                                    color: menuitem.textColor
                                    font.family: "sans-serif"
                                    //anchors.verticalCenter: parent
                                }

                            }


                        }
                    }

                    onClicked: {

                        //recover background color first
                        listView.currentItem.backgroundColor = "transparent"
                        listView.currentItem.textColor = listView.defaultTextColor
                        listView.currentItem.iconColor = imgSource

                        //change state in main.qml
                        currPage = name

                        //change backgroundColor
                        listView.currentIndex = index
                        listView.currentItem.backgroundColor = listView.hoveredBackgroundColor
                        listView.currentItem.textColor = listView.pressedTextColor
                        listView.currentItem.iconColor = hoveredSource


                    }

                }

            }

        }

    }


}



