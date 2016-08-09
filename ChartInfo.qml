import QtQuick 2.0
import QtQuick.Layouts 1.0
import "componentCreation.js" as ComponentCreateScript



Rectangle {

    id: chartRect
    height: 100
    border.color: "black"
    color: "#b3f4f4"
    property var canvas: null

    Text{
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        text: "LineSeries: "
    }

    Component.onCompleted: {

        canvas.addNewRect.connect( function(item){
            console.log("in ChartInfo")
            console.log("recvItem =" + item )

            var component
            var button
            component = Qt.createComponent("Button.qml")
            button = component.createObject( chartRect, { "x" : 50, "y": 50 } )
            if( button !== null ){
                console.log("create object successfully")
            }

            //ComponentCreateScript.createLineSerisInfos()
        })
    }






}



