import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1

ScrollView {

    property alias frameModel: frameModel
    anchors.fill: parent
    frameVisible: true

    ListView{
        anchors.fill: parent
        spacing: 10
        id: frameListView
        model: frameModel
        delegate: frameDelegate
        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds

        ListModel{
            id: frameModel
        }

        Component{
            id: frameDelegate
            Rectangle{

                width: parent.width
                height: 500

                RowLayout{

                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    spacing: 50

                    Column{
                        Text{ text: ' index = ' + index }
                        Text{ text: ' hr_bpm = ' + hr_bpm }
                        Text{ text: ' rr_bpm = ' + rr_bpm }
                        Text{ text: ' interval = ' + interval }
                        Text{ text: ' lambda = ' + lambda }
                        Text{ text: ' eb_ts = ' + eb_ts }
                    }

                    Image{ source: "image://provider/" + index.toString() }

                }

            }
        }


    }

    style: ScrollViewStyle{

         transientScrollBars: true
         handle: Item {
             implicitWidth: 14
             implicitHeight: 26
             Rectangle {
                 color: "#424246"
                 anchors.fill: parent
                 anchors.topMargin: 6
                 anchors.leftMargin: 4
                 anchors.rightMargin: 4
                 anchors.bottomMargin: 6
             }
         }

         scrollBarBackground: Item {
             implicitWidth: 14
             implicitHeight: 26
         }

    }


}
