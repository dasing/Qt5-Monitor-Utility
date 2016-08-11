import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtCharts 2.1
import qmlvideofilter 1.0

ColumnLayout {

    width: 200
    height: 720
    spacing: 4
    property alias brightnessValue: chartView.brightnessValue
    property alias brightnessValue2: chartView2.brightnessValue2
    property alias x_result: chartView.x_result
    property alias y_result: chartView2.y_result


    ChartView{

        id: chartView
        width: 500
        height: 300
        animationOptions: ChartView.AllAnimations
        theme: ChartView.ChartThemeBlueIcy

        property var x_result: null

        property double brightnessValue
//        onBrightnessValueChanged: {
//            //console.log("brightnessValueChanged to " + brightnessValue )
//            updateSeries( series(0), brightnessValue )

//        }

        onX_resultChanged: {
            console.log("x_result changed")
            //displayElement(x_result)
        }

        ValueAxis{
            id: axisX
            min: 0
            max: 100

        }

        ValueAxis {
            id: axisY
            min: 0
            max: 500
        }

//        LineSeries{
//            id: birghtnessSeris1
//            name: "brightness"
//            axisX: axisX
//            axisY: axisY
//        }

    }

    ChartView{

        id: chartView2
        width: 500
        height: 300
        animationOptions: ChartView.AllAnimations
        theme: ChartView.ChartThemeBrownSand

        property var y_result: null

        property double brightnessValue2
//        onBrightnessValue2Changed: {
//            //console.log("brightnessValue2Changed to " + brightnessValue2 )
//            updateSeries( series(0), brightnessValue2 )

//        }

        onY_resultChanged: {
            console.log("y_result changed")
            //displayElement( y_result )
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

//        LineSeries{
//            id: birghtnessSeris2
//            name: "ststicPointBrightness"
//            axisX: axisX2
//            axisY: axisY2
//        }

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
            //console.log("add " + chartView.series(idx).at(pointCount ).x + " " + chartView.series(idx).at(pointCount ).y + " to lineSeries");

        }else{

            /*replace*/
            //console.log("pointCount = " + pointCount );
            for( var i=0; i< pointCount-1; i++ ){


    //                console.log("before replace");
    //                console.log("old point: " +  chartView.series(idx).at(i).x + ", " +  chartView.series(idx).at(i).y );
    //                console.log("new point: " +  chartView.series(idx).at(i+1).x + ", " +  chartView.series(idx).at(i+1).y );

                m_lineSeries.replace( m_lineSeries.at(i).x, m_lineSeries.at(i).y, m_lineSeries.at(i).x, m_lineSeries.at(i+1).y );
    //                console.log("after replace");
    //                console.log("old point: " +  chartView.series(idx).at(i).x + ", " +  chartView.series(idx).at(i).y );
    //                console.log("new point: " +  chartView.series(idx).at(i+1).x + ", " +  chartView.series(idx).at(i+1).y );
            }

            /*Add new value*/
            m_lineSeries.replace( m_lineSeries.at(i).x, m_lineSeries.at(i).y, m_lineSeries.at(i).x, newValue );

        }


    }

}

