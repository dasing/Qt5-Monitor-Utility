#include "bcvencoder.h"
#include "bcvencoderrunable.h"
#include "bcv_file.h"
#include "time.h"
#include <fstream>
#include <QAbstractVideoFilter>
#include <iostream>
#include <QByteArray>
#include <QDebug>
#include <QDir>

using namespace std;

BCVEncoder::BCVEncoder()
{

    m_totalFrame = 0;
}

QVideoFilterRunnable* BCVEncoder::createFilterRunnable(){

    return new bcvencoderrunable(this);
}

void BCVEncoder::initializeBCVEncoder(){

    //use current time as file name
    time_t t = time(0); //get time now
    struct tm* now = localtime( &t );

    int year = now->tm_year + 1900;
    int mon = now->tm_mon + 1;
    int day = now->tm_mday;
    int hour = now->tm_hour;
    int min = now->tm_min;
    int sec = now->tm_sec;

    QString time_hour = hour < 10 ? "0" + QString::number(hour) : QString::number(hour);
    QString time_min = min < 10 ? "0" + QString::number(min) : QString::number(min);
    QString fileName = QString::number(year) + "-" + QString::number(mon) + "-" + QString::number(day) + "_" + time_hour + "_" + time_min + ".bcv";
    qDebug() << "fileName = " << fileName;

    //Open File
    file.setFileName(fileName);
    //WARNING: if application is not run on Qt creator, file storing path may change and thus cause open error
    QDir::setCurrent("/Users/Dasing/Desktop/build-Utility-Desktop_Qt_5_7_0_clang_64bit-Debug");
    file.open(QIODevice::WriteOnly);
    file.setTextModeEnabled(false);


    QDataStream out(&file);

    //Initialize Parameters
    m_totalFrame = 0; //parameter which notes for Image number stored in bcvfile

    _bcv_video_header header;

    memcpy( header.magic,"biotrump", sizeof(uint8_t)*8 );
    header.version = (uint32_t)195;
    header.width = (uint16_t)640;
    header.height = (uint16_t)480;
    header.fps = 30.0;
    header.pix_fmt = (uint32_t)1; //ARGB8888
    header.total_frames = (uint16_t)0;
    header.date_year = (int16_t)year;
    header.date_mmdd = ( mon << 8 ) + day;
    header.date_hhmin = ( hour << 8 ) + min;
    header.date_sec = (int16_t) sec;
    memcpy( header.cam_name, "FaceTimeHD\0", sizeof(uint8_t)*16 );
    header.nir_baseline = (uint8_t)'c';
    header.nir_channels = (uint8_t)'c';
    memset( header.nir_lambda, '0', sizeof(uint8_t) * 198 ); // 198 = 256 - 58 (meaningful information )

    //write dataStructure to file
    out.writeRawData((const char*)header.magic, 8 );
    out << header.version;
    out << header.width;
    out << header.height;
    cout << "curr_fileSize = " << file.size() << endl;
    out << header.fps;
    cout << "curr_fileSize = " << file.size() << endl;
    out << header.pix_fmt;
    out << header.total_frames;
    out << header.date_year;
    out << header.date_mmdd;
    out << header.date_hhmin;
    out << header.date_sec;
    out.writeRawData((const char*)header.cam_name, 16 );
    out << header.nir_baseline;
    out << header.nir_channels;
    out.writeRawData((const char*)header.nir_lambda, 198 );
    printf("size of file = %lld\n" , file.size() );


//Debug
//    cout << header.magic;
//    cout << header.version;
//    cout << header.width;
//    cout << header.height;
//    cout << header.fps;
//    cout << header.pix_fmt;
//    cout << header.total_frames;
//    cout << header.date_year;
//    cout << header.date_mmdd;
//    cout << header.date_hhmin;
//    cout << header.date_sec;
//    cout << "month = " << (header.date_mmdd >> 8 );
//    cout << "day = " << (header.date_mmdd & 0xff );
//    cout << "debug : nir_lambda = " << *(header.nir_lambda) << endl;
//    cout << "cam_name = "<< header.cam_name << endl;

}

float clamp( float value, int lv, int hv ){

    if( value < lv )
        value = lv;
    else if( value > hv )
        value = hv;

    return value;
}


quint32 turnRGB2int( int r, int g, int b ){

    quint32 val;
    val = r;
    val = ( val << 8 ) + g;
    val = ( val << 8 ) + b;

    return val;
}

QRgb convertYUVtoRGB( int y, int u, int v ){

    float r = ( (float)y + 1.402f*(float)v );
    float g = ( (float)y -  0.344f*(float)u - 0.714f*(float)v  );
    float b = ( (float)y + 1.772f*(float)u );

    int int_r = clamp( r, 0, 255 );
    int int_g = clamp( g, 0, 255 );
    int int_b = clamp( b, 0, 255 );

    return qRgb( int_r, int_g, int_b );
}

void int2char( int value, char buffer[4] ){

    uint32_t val = (uint32_t)value;
    cout << "val = " << val << endl;
    for( int i=3; i>=0; i-- ){
        buffer[i] = ( val >>  ( 8*i ) ) & 0xFF;
    }

}

void BCVEncoder::updateTotalFrames(){

    //update totalFrames

    char buffer[4];

    fstream outfile( file.fileName().toStdString() );
    outfile.seekp ( 28, ios_base::beg ); // totalFrames is on 28 bytes
    int2char( m_totalFrame, buffer );
    outfile.write ( (const char*)buffer ,4);
    outfile.close();

}

void BCVEncoder::writeFiles(){

    QDataStream out(&file);

    for( int index =0; index < m_totalFrame; index++ ){

        //write header
        _bcv_video_frame curr = frameHeaderList.at(index);

        out << curr.index;
        out << curr.hr_bpm;
        out << curr.rr_bpm;
        out << curr.interval;
        out << curr.lamda;
        out << curr.eb_ts;
        out.writeRawData( (const char*)curr.reserved, 17 ); // 17 = 32 - 15

        //write Image, should be extended to general form
        unsigned char* Y = YList.at( index );
        unsigned char* UV = UVList.at( index );

        int width = 640;
        int height = 480;
        int size = width * height;
        int halfSize = size/2;

        out.writeRawData( (char*)Y, size );
        out.writeRawData( (char*)UV, halfSize );

//        QImage img( width, height, QImage::Format_RGB32 );
//        img.fill(QColor(Qt::white).rgb());

//        for( int i=0, k=0, y=0, x=0; i< size; i+=2, k+=2 ){

//            //i ->pointer of Y data
//            //k ->pointer of UV data
//            //x, y ->position of image

//            int y1 = Y[i];
//            int y2 = Y[i+1];
//            int y3 = Y[i+width];
//            int y4 = Y[i+height+1];

//            int u = UV[k];
//            int v = UV[k+1];
//            u -= 128;
//            v -= 128;

//            img.setPixel( x, y, convertYUVtoRGB(  y1, u, v ) );
//            img.setPixel( x, y+1, convertYUVtoRGB(  y2, u, v ) );
//            img.setPixel( x+1, y, convertYUVtoRGB( y3, u, v ) );
//            img.setPixel( x+1, y+1, convertYUVtoRGB(  y4, u, v ) );

//            if( i!=0 && ( (i+2) % width ) == 0 ){
//                //cross a line
//                i+= width;
//            }

//            x += 2;

//            if( x == width ){
//                x = 0;
//                y += 2;
//            }

//        }

//        QString dir =  QDir::currentPath().append( "/test" +QString::number( index ) + ".png" );
//        //qDebug() << "save dir = " << dir;

//        bool result = img.save( dir );
//        if( !result )
//            printf("file save fail\n");

    }
}

void BCVEncoder::resetMemory(){

    //reset YList
    for( int i=0; i<YList.length(); i++ ){
        delete YList.at(i);
    }

    YList.clear();

    //reset UVList
    for( int i=0; i<UVList.length(); i++ ){
        delete UVList.at(i);
    }

    UVList.clear();
}

void BCVEncoder::resetBCVEncoder(){


    qDebug() << "frame Number = " << m_totalFrame;
    writeFiles();
    file.close();
    resetMemory();

    updateTotalFrames();

    //reset parameter
    m_totalFrame = 0;

    if ( !file.flush() )
        printf("flush error\n");
}

