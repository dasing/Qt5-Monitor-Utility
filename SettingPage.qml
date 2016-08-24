import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtMultimedia 5.5
import QtQuick.Layouts 1.0

ColumnLayout {


    signal changeCamera( var cameraID )

    RowLayout{

        spacing: 20

        Text{
            id: cameraSettingText
            text: "Camera Setting"
        }

        ComboBox{

            id: control
            width: 300
            model: QtMultimedia.availableCameras
            currentIndex: 0
            textRole: "displayName"

            onActivated: {
                changeCamera( model[currentIndex].deviceId )
            }


            background: Rectangle{

                border.color: control.pressed ? "#17a81a" : "#21be2b"
                border.width: control.visualFocus ? 2 : 1
                radius: 2
            }

            indicator: Canvas {

                id: indicatorcanvas
                x: control.width - width - control.rightPadding
                y: control.topPadding + (control.availableHeight - height) / 2
                width: 12
                height: 8
                contextType: "2d"

                Connections {
                    target: control
                    onPressedChanged: indicatorcanvas.requestPaint()
                }

                onPaint: {
                    context.reset();
                    context.moveTo(0, 0);
                    context.lineTo(width, 0);
                    context.lineTo(width / 2, height);
                    context.closePath();
                    context.fillStyle = control.pressed ? "#17a81a" : "#21be2b";
                    context.fill();
                }
            }


        }

    }



}
