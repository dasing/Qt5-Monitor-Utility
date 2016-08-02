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

//    Rectangle{
//        id: rect1
//        anchors.top: parent.top
//        anchors.topMargin: 10
//        width: 200
//        height: 200
//        color: "steelblue"
//    }

    ChartView{

        id: chartView
        width: 500
        height: 300
        animationOptions: ChartView.AllAnimations
        theme: ChartView.ChartThemeBlueIcy

        property double brightnessValue
        onBrightnessValueChanged: {
            //console.log("brightnessValueChanged to " + brightnessValue )
            updateSeries( series(0), brightnessValue )

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

        LineSeries{
            id: birghtnessSeris1
            name: "brightness"
            axisX: axisX
            axisY: axisY
        }

    }

    ChartView{

        id: chartView2
        width: 500
        height: 300
        animationOptions: ChartView.AllAnimations
        theme: ChartView.ChartThemeBrownSand

        property double brightnessValue2
        onBrightnessValue2Changed: {
            //console.log("brightnessValue2Changed to " + brightnessValue2 )
            updateSeries( series(0), brightnessValue2 )

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

        LineSeries{
            id: birghtnessSeris2
            name: "ststicPointBrightness"
            axisX: axisX2
            axisY: axisY2
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

//    function countPoint(idx) {

//        var p = 0;
//        while(1){
//            //console.log("p = " + p );
//            var point = chartView.series(idx).at(p);
//            if( point.x === 0 && point.y === 0  ) //if the idx is invalid, function will return (0, 0)
//                break;
//            else
//                p++;
//        }

//        return p;

//    }

//    function updateSeries(idx, newValue ){

//        var pointCount = countPoint(idx);
//        var limit = 10
//        if( pointCount < limit ){


//            chartView.series(idx).append( (pointCount+1)*10, newValue );
//            //console.log("add " + chartView.series(idx).at(pointCount ).x + " " + chartView.series(idx).at(pointCount ).y + " to lineSeries");

//        }else{

//            /*replace*/
//            //console.log("pointCount = " + pointCount );
//            for( var i=0; i< pointCount-1; i++ ){


////                console.log("before replace");
////                console.log("old point: " +  chartView.series(idx).at(i).x + ", " +  chartView.series(idx).at(i).y );
////                console.log("new point: " +  chartView.series(idx).at(i+1).x + ", " +  chartView.series(idx).at(i+1).y );

//                chartView.series(idx).replace( chartView.series(idx).at(i).x, chartView.series(idx).at(i).y, chartView.series(idx).at(i).x, chartView.series(idx).at(i+1).y );
////                console.log("after replace");
////                console.log("old point: " +  chartView.series(idx).at(i).x + ", " +  chartView.series(idx).at(i).y );
////                console.log("new point: " +  chartView.series(idx).at(i+1).x + ", " +  chartView.series(idx).at(i+1).y );
//            }

//            /*Add new value*/
//            chartView.series(idx).replace( chartView.series(idx).at(i).x, chartView.series(idx).at(i).y, chartView.series(idx).at(i).x, newValue );

//        }


//    }
}

