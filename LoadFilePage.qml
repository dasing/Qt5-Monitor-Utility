import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0

Item {

        width: 580
        height: 400
        SystemPalette { id: palette }
        clip: true

        FileDialog {
            id: fileDialog
            visible: false
            modality: Qt.WindowModal
            title: "Choose a file"
            selectExisting: true
            selectMultiple: false
            selectFolder: false
            nameFilters: [ "(*.bcv)" ]
            selectedNameFilter: "(*.bcv)"
        }

        ScrollView {
               id: scrollView
               anchors {
                   left: parent.left
                   right: parent.right
                   top: parent.top
                   leftMargin: 12
               }
               ColumnLayout {

                   spacing: 8
                   //Item { Layout.preferredHeight: 4 } // padding

                   Label {
                        text: "<b>chosen files:</b> " + fileDialog.fileUrls
                   }

                   Button {
                       id: button

                       text: "Find"
                       onClicked: {
                           fileDialog.visible = true
                           fileDialog.open()
                       }
                   }
              }
         }



}
