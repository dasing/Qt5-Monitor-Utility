var component;
var seriesInfo;

function deleteLineSeries( seriesName, index ){
    console.log( seriesName + " is deleted. Index = " + index )
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
