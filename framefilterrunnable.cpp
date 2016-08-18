#include "framefilterrunnable.h"
#include "analyzeresult.h"
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include<QAbstractVideoFilter>
#include <QDebug>
#include <qglobal.h>
#include <QTime>

//using namespace cv;

FrameFilterRunnable::FrameFilterRunnable( FrameFilter* filter ) : QVideoFilterRunnable(){

    m_filter = filter;


}

int computeData( int min, int max ){

    qsrand(time(NULL));
    int returnValue =   qrand() % ((max+1) -min)  +min ;
    //qDebug() << "return " << returnValue;

    return returnValue;


}

QVideoFrame FrameFilterRunnable::run( QVideoFrame *input, const QVideoSurfaceFormat &surfaceFormat, RunFlags flags ){

    AnalyzeResult *result = new AnalyzeResult();


    if( input->isValid() ){

        //Whole input
//        result->m_xResult.append( computeData( 0, input->width()-1 ) );
//        result->m_yResult.append( computeData( 0, input->height()-1 ) );

        //ROI
        if( m_filter->arealist.size() != 0 ){

            int size = m_filter->arealist.size();
            for( int i=0 ; i<size; i++ ){
                //DO ROI
                int x0 = m_filter->arealist.at(i)->x();
                int y0 = m_filter->arealist.at(i)->y();
                int width = m_filter->arealist.at(i)->width();
                int height = m_filter->arealist.at(i)->height();

                result->m_xResult.append( computeData( x0, x0 + width-1 ) );
                result->m_yResult.append( computeData( y0, y0 + height-1 ) );
            }

        }

        emit m_filter->finished(result);

    }

    /* Image Processing Using OpenCV*/

//    AnalyzeResult *result = new AnalyzeResult();
//    //convert image to suitable cv type
//    if( input->isValid() ){
//        //map the video buffer to memory
//        input->map(QAbstractPlanarVideoBuffer::ReadWrite);

//        //QVideoFrame to cv::Mat and do image-processing
//        Mat cvImg = Mat(input->height(), input->width(), CV_8UC3, input->bits(), input->bytesPerLine() );
//        Mat grayImg;

//        cvtColor( cvImg, grayImg, CV_RGB2GRAY );
//        //double value = 0;


//        qsrand(time(NULL));
//        int y_idx = qrand() % grayImg.rows;
//        int x_idx = qrand() % grayImg.cols;


//        /* The following method will overflow*/
////        for( int y = 0; y < grayImg.rows; y++ ){
////            for( int x = 0; x < grayImg.cols; x++ ){
////                value += grayImg.at<uchar>( y, x );
////                qDebug() << "pixel value at ( " << y << ", " << x << " ) is " <<  grayImg.at<uchar>( y, x );
////                qDebug() << "value = " << value;
////            }
////        }

//        //qDebug() << "in c++, x_start = " <<  m_filter->x_start();
//        int sy_idx = 34, sx_idx = 900;

//        result->setBrightness( grayImg.at<uchar>( y_idx, x_idx) );
//        result->setBrightness2( grayImg.at<uchar>(sy_idx, sx_idx ) );

//        //qDebug() << "brightness = " << result->brightness();
//        //qDebug() << "brightness2 = " << result->brightness2();

//        input->unmap();

//        emit m_filter->finished(result);
//        return *input;

//    }

    return *input;

}
