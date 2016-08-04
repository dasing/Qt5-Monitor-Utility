#include "framefilterrunnable.h"
#include "analyzeresult.h"
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include<QAbstractVideoFilter>
#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <QDebug>
#include <qglobal.h>
#include <QTime>

using namespace cv;

FrameFilterRunnable::FrameFilterRunnable( FrameFilter* filter ) : QVideoFilterRunnable(){

    m_filter = filter;



}

//void setRange( int x1, int x2, int y1, int y2 ){

//    if( x1 != -1 )
//        x_start = x1;

//    if( x2 != -1 )
//        x_end = x2;

//    if( y1 != -1 )
//        y_start = y1;

//    if( y2 != -1 )
//        y_end = y2;

//}

QVideoFrame FrameFilterRunnable::run( QVideoFrame *input, const QVideoSurfaceFormat &surfaceFormat, RunFlags flags ){

    //ROI
    if( m_filter->updateFlag() ){

        printf("framefilterrunnable should update selectionList\n"); //printf many lines, should I set lock?
        //upateSelectionList( newSelectionList );
        //m_filter->setUpdateFlag(0);

        //printf("in c++, updateFlag = %d\n", m_filter->updateFlag() );

    }

    AnalyzeResult *result = new AnalyzeResult();
    //convert image to suitable cv type
    if( input->isValid() ){
        //map the video buffer to memory
        input->map(QAbstractPlanarVideoBuffer::ReadWrite);

        //QVideoFrame to cv::Mat and do image-processing
        Mat cvImg = Mat(input->height(), input->width(), CV_8UC3, input->bits(), input->bytesPerLine() );
        Mat grayImg;

        cvtColor( cvImg, grayImg, CV_RGB2GRAY );
        //double value = 0;


        qsrand(time(NULL));
        int y_idx = qrand() % grayImg.rows;
        int x_idx = qrand() % grayImg.cols;


        /* The following method will overflow*/
//        for( int y = 0; y < grayImg.rows; y++ ){
//            for( int x = 0; x < grayImg.cols; x++ ){
//                value += grayImg.at<uchar>( y, x );
//                qDebug() << "pixel value at ( " << y << ", " << x << " ) is " <<  grayImg.at<uchar>( y, x );
//                qDebug() << "value = " << value;
//            }
//        }

        //qDebug() << "in c++, x_start = " <<  m_filter->x_start();
        int sy_idx = 34, sx_idx = 900;

        result->setBrightness( grayImg.at<uchar>( y_idx, x_idx) );
        result->setBrightness2( grayImg.at<uchar>(sy_idx, sx_idx ) );

        //qDebug() << "brightness = " << result->brightness();
        //qDebug() << "brightness2 = " << result->brightness2();

        input->unmap();
        emit m_filter->finished(result);
        return *input;

    }

    return *input;


}
