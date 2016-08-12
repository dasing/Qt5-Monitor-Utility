import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtCharts 2.1
import qmlvideofilter 1.0

ColumnLayout {

    width: 200
    height: 720
    spacing: 4

    property alias x_result: chartView.x_result
    property alias y_result: chartView2.y_result


    ChartView{

        id: chartView
        width: 500
        height: 300
        animationOptions: ChartView.SeriesAnimations
        //legend.visible: false
        theme: ChartView.ChartThemeBlueIcy

        property var x_result: null
        property int x_resultSize: 0

        onX_resultChanged: {


            //displayElement(x_result)

            var currSize = x_result === null ? -1 : x_result.length
            //console.log("x_result changed, currSize = " + currSize )

            if( currSize > 0 ){

                if( currSize > 0 &&  currSize > x_resultSize ){
                    addLineSeries( chartView , "lineSeris"+currSize , axisX, axisY )
                    //listSeriesColor( chartView )
                }else{
                    //removeLineSeries()
                }

                updateChartValue( chartView, x_result )

            }

            x_resultSize = currSize

        }

        ValueAxis{
            id: axisX
            min: 0
            max: 100

        }

        ValueAxis {
            id: axisY
            min: 0
            max: 800
        }

    }

    ChartView{

        id: chartView2
        width: 500
        height: 300
        animationOptions: ChartView.AllAnimations
        theme: ChartView.ChartThemeBrownSand
        //legend.visible: false

        property var y_result: null
        property int y_resultSize: 0

        onY_resultChanged: {

            var currSize = y_result === null ? -1 : y_result.length
            //console.log("y_result changed, currSize = " + currSize )

            if( currSize > 0 ){

                if( currSize > 0 &&  currSize > y_resultSize ){
                    addLineSeries( chartView2 , "lineSeris"+currSize , axisX2, axisY2 )
                    //listSeriesColor( chartView2 )
                }else{
                    //removeLineSeries()
                }

                updateChartValue( chartView2, y_result )

            }

            y_resultSize = currSize
        }

        ValueAxis{
            id: axisX2
            min: 0
            max: 100

        }

        ValueAxis {
            id: axisY2
            min: 0
            max: 500
        }

    }

    function displayElement( list ){
        var size = list.length
        console.log("list size is " + size )
        for( var i=0; i<size; i++ ){
            console.log(list[i])
        }
    }


    function countPoint( m_lineSeries ) {

        var p = 0;
        while(1){
            //console.log("p = " + p );
            var point = m_lineSeries.at(p);
            if( point.x === 0 && point.y === 0  ) //if the idx is invalid, function will return (0, 0)
                break;
            else
                p++;
        }

        return p;

    }

    function updateSeries( m_lineSeries, newValue ){

        var pointCount = countPoint( m_lineSeries );
        var limit = 10
        if( pointCount < limit ){

            m_lineSeries.append( (pointCount+1)*10, newValue );
            //console.log("add " + m_lineSeries.at(pointCount ).x + " " + m_lineSeries.at(pointCount ).y + " to lineSeries");

        }else{

            var i;
//            console.log("before replace")
//            for( i=0; i< pointCount-1; i++ ){
//                console.log( "x = " +  m_lineSeries.at(i).x + " ,y = " + m_lineSeries.at(i).y );
//            }

            /*replace*/
            //console.log("pointCount = " + pointCount );
            for( i=0; i< pointCount-1; i++ ){
                m_lineSeries.replace( m_lineSeries.at(i).x, m_lineSeries.at(i).y, m_lineSeries.at(i).x, m_lineSeries.at(i+1).y );
            }

            /*Add new value*/
            m_lineSeries.replace( m_lineSeries.at(i).x, m_lineSeries.at(i).y, m_lineSeries.at(i).x, newValue );

//            console.log("after replace")
//            for( i=0; i< pointCount-1; i++ ){
//                console.log( "x = " +  m_lineSeries.at(i).x + " ,y = " + m_lineSeries.at(i).y );
//            }

        }

    }

    function updateChartValue( chart, list ){
        var count = list.length
        for( var i=0; i<count; i++ ){
            updateSeries( chart.series(i), list[i] )
        }
    }

    function addLineSeries( chart, seriesName, axis1, axis2 ){

        chart.createSeries( ChartView.SeriesTypeSpline, seriesName, axis1, axis2 );
    }

    function listSeriesColor( chart ){

        var seriesNumber = chart.count;
        for( var i=0; i<seriesNumber; i++ ){
            console.log( chart.series(i).color )
        }

    }

}

