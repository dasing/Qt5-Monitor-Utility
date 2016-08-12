import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

RowLayout {

    id: seriesInfo
    objectName: "seriesInfo"
    anchors.left: parent.left
    anchors.leftMargin: 40

    property int index: -1
    property bool _visible: true
    property alias seriesColor: seriesColor

    signal deleteLineSeries( string seriesName, int index )

    Button{

        id: cancel
        anchors.left: parent.left
        anchors.top: parent.top
        style: ButtonStyle{
            background: Rectangle{

                implicitHeight: 20
                implicitWidth: 20
                color: "transparent"

                Image{
                    anchors.fill: parent
                    source: "qrc:/cancel.png"
                }
            }

        }

        onClicked: {
            console.log("click cancel")
            deleteLineSeries(seriesInfo.objectName, seriesInfo.index )
            seriesInfo.destroy()
        }

    }

    Button{
        property string imageSource: seriesInfo._visible ? "qrc:/dark-eye.png" : "qrc:/gray-eye.png"

        id: view
        anchors.left: cancel.right
        anchors.leftMargin: 15

        style: ButtonStyle{
            background: Rectangle{

                implicitHeight: 25
                implicitWidth: 25
                color: "transparent"

                Image{
                    anchors.fill: parent
                    source: seriesInfo._visible ? "qrc:/dark-eye.png" : "qrc:/gray-eye.png"
                }
            }

        }

        onClicked:{
            _visible = _visible ? false : true;
            changeVisible( seriesInfo.index )

        }
    }

    Rectangle{

        id: seriesColor
        width: 20
        height: 20
        color: "red"
        anchors.left: view.right
        anchors.leftMargin: 40

    }

    Text{

        id: seriesName
        text: seriesInfo.objectName
        anchors.left: seriesColor.right
        anchors.leftMargin: 10
    }

}
