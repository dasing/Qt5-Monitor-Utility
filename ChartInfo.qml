import QtQuick 2.0
import QtQuick.Layouts 1.0
import "componentCreation.js" as ComponentCreateScript

Rectangle {

    id: chartRect
    height: 70
    border.color: "black"
    color: "white"
    property var chartScope: null
    property var canvas: null
    property int activeLineSeries: 0
    property int deletedIndex: -1
    property int itemHeight: 30

    Text{
        id: title
        objectName: "text"
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        text: "LineSeries: "
    }

    Component.onCompleted: {

        chartScope.addNewRect.connect( function( name, color){

            console.log("in ChartInfo")
            console.log("recvItem =" + name + " " + color  )

            chartRect.activeLineSeries += 1
            ComponentCreateScript.createLineSerisInfos( chartRect.activeLineSeries, name, color  )
            chartInfo.height += itemHeight

        })
    }

    onChildrenChanged: {
        //console.log("children changed")

        if( deletedIndex !== -1 ){
            ComponentCreateScript.updateIndex( deletedIndex )
            ComponentCreateScript.updateItemPosition( deletedIndex )
            chartInfo.height -= itemHeight
        }
    }

}



