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

QVideoFrame FrameFilterRunnable::run( QVideoFrame *input, const QVideoSurfaceFormat &surfaceFormat, RunFlags flags ){

    //ROI
    if( m_filter->arealist.size() != 0 ){

        int size = m_filter->arealist.size();
        for( int i=0 ; i<size; i++ ){
            //DO ROI
        }

    }else{

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
