var component;
var seriesInfo;

function updateItemPosition( startIndex ){

    var size = chartRect.children.length
    for( var i = startIndex; i < size; i++ ){
        chartRect.children[i].y -= 30
    }
}

function listAllChildren(){

    console.log( " in listAllChildren" )
    var size = chartRect.children.length
    for( var i=0; i<size; i++ ){
        console.log( chartRect.children[i].objectName + " index is " + chartRect.children[i].index )
    }
}

function updateIndex( deletedIndex ){

    var size = chartRect.children.length
    for( var i=deletedIndex; i < size; i++ ){
        chartRect.children[i].index -= 1
    }

    listAllChildren()

}

function deleteLineSeries( seriesName, index ){

    console.log( seriesName + " is deleted. Index = " + index )
    chartRect.deletedIndex = index
}

function createLineSerisInfos( activeLineSeries ) {

        component = Qt.createComponent("LineSeriesInfo.qml");

        if( component.status === Component.Ready ){
            //console.log("here1");
            finishCreation( activeLineSeries );
        }else{
            console.log(component.status);
            console.log("Error loading component: ", component.errorString() );
            component.statusChanged.connect( finishCreation( activeLineSeries ) );
        }

}

function finishCreation( activeLineSeries){

    var topMargin = 38
    var itemHeight = 25
    var gap = 5

    if( component.status === Component.Ready ){

        seriesInfo = component.createObject( chartRect, { "x" : 0, "y": topMargin + itemHeight * (activeLineSeries-1) + gap*( activeLineSeries-1 ) } );
        if( seriesInfo === null ){
            console.log("Error creating object");
        }else{
            //console.log("object create successful");
            seriesInfo.objectName = "seriesInfo" + activeLineSeries;
            seriesInfo.index = activeLineSeries;
            seriesInfo.deleteLineSeries.connect(  deleteLineSeries  );


        }

    }else if( component.status === Component.Error ){
        console.log("Error loading component: ", component.errorString() );
    }


}
