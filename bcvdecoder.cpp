#include "bcvdecoder.h"
#include "bcv_file.h"
#include <QFile>
#include <iostream>
#include <QDebug>
#include <QDir>
#include <QDataStream>
#include <cstring>
#include <QImage>
#include <fstream>

#define BCV_MAGIC_STR_LEN		(8)

BCVDecoder::BCVDecoder(){
    totalFrame = 0;
    width = 0;
    height = 0;
}

uint32_t char2int( char buffer[4] ){

    uint32_t value;
    value = ((unsigned char)buffer[3] << 24 ) | ((unsigned char)buffer[2] << 16 )  | ((unsigned char)buffer[1] << 8 )  | ((unsigned char)buffer[0] << 0 );
   // cout << "read value = " << value << endl;

    return value;
}


QString BCVDecoder::decodeVideoHeader( QDataStream& in, _bcv_video_header* header ){

    char totalFrameBuffer[4];
    in.readRawData( (char*)header->magic, 8 );
    in >> header->version;
    in >> header->width;
    in >> header->height;
    in >> header->fps;
    in >> header->pix_fmt;
    in.readRawData( totalFrameBuffer, 4 );
    header->total_frames = char2int( totalFrameBuffer );
    in >> header->date_year;
    in >> header->date_mmdd;
    in >> header->date_hhmin;
    in >> header->date_sec;
    in.readRawData( (char*)header->cam_name, 16 );
    in >> header->nir_baseline;
    in >> header->nir_channels;
    in.readRawData( (char*)header->nir_lambda, 198 ); // 198 = 256 - 58

    int mon = ( header->date_mmdd >> 8 );
    int day =  (header->date_mmdd & 0xff );
    int hour = (header->date_hhmin >> 8 );
    int min = (header->date_hhmin & 0xff );

    QString result = QString::number(header->version) + ";" + QString::number(header->width) + ";" + QString::number(header->height) + ";" +
                     QString::number(header->fps) + ";" + QString::number(header->pix_fmt) + ";" + QString::number(header->total_frames) + ";" +
                     QString::number(header->date_year) + ";" + QString::number(mon) + ";" + QString::number(day) + ";" + QString::number(hour) + ";" +
                     QString::number(min) + ";" + QString::number(header->date_sec) + ";" + QString((char*)header->cam_name) + ";" + QString(header->nir_baseline) + ";" +
                     QString(header->nir_channels);

    totalFrame = header->total_frames;
    width = header->width;
    height = header->height;

        //OUTPUT DEBUG
//        cout << header->magic << endl;
//        cout << header->version << endl;
//        cout << header->width << endl;
//        cout << header->height << endl;
//        cout << header->fps << endl;
//        cout << header->pix_fmt << endl;
//        cout << header->total_frames << endl;
//        cout << header->date_year << endl;
//        cout << header->date_mmdd << endl;
//        cout << header->date_hhmin << endl;
//        cout << header->date_sec << endl;
//        cout << header->nir_baseline << endl;
//        cout << header->nir_channels << endl;

//        cout << "year0 = " << (header->date_year >> 8 ) << endl;
//        cout << "year1 = " << (header->date_year & 0xff ) << endl;
//        cout << "month = " << (header->date_mmdd >> 8 ) << endl;
//        cout << "day = " << (header->date_mmdd & 0xff ) << endl;
//        cout << "hour = " << (header->date_hhmin >> 8 ) << endl;
//        cout << "min = " << (header->date_hhmin & 0xff ) << endl;
//        cout << "sec0 = " << (header->date_sec >> 8 ) << endl;
//        cout << "sec1 = " << (header->date_sec & 0xff ) << endl;

    return result;

}

QString BCVDecoder::decodeFrameHeader( QDataStream& in, _bcv_video_frame* header ){


    in >> header->index;
    in >> header->hr_bpm;
    in >> header->rr_bpm;
    in >> header->interval;
    in >> header->lamda;
    in >> header->eb_ts;
    in.readRawData( (char*)header->reserved, 17 );


    //Debug
    cout << "index = " << header->index << endl;
    cout << "hr_bpm = " << header->hr_bpm << endl;
    cout << "rr_bmp = " << header->rr_bpm << endl;
    cout << "interval = " << header->interval << endl;
    cout << "lambda = " << header->lamda << endl;
    cout << "eb_ts = " << header->eb_ts << endl;

    QString result = QString::number(header->index) + ";" + QString::number(header->hr_bpm) + ";" + QString::number(header->rr_bpm) + ";" +
                     QString::number(header->interval) + ";" + QString::number(header->lamda) + ";" + QString::number(header->eb_ts);

    return result;

}

float clamp2( float value, int lv, int hv ){

    if( value < lv )
        value = lv;
    else if( value > hv )
        value = hv;

    return value;
}

QRgb turnInt2QRgb( qint32 color ){

    int r = ( color >> 16 ) & 0xFF;
    int g = ( color >> 8 ) & 0xFF;
    int b = color & 0xFF;

    return qRgb( r, g, b );
}


QRgb YUV2RGB( int y, int u, int v ){

    float r = ( (float)y + 1.402f*(float)v );
    float g = ( (float)y -  0.344f*(float)u - 0.714f*(float)v  );
    float b = ( (float)y + 1.772f*(float)u );

    int int_r = clamp2( r, 0, 255 );
    int int_g = clamp2( g, 0, 255 );
    int int_b = clamp2( b, 0, 255 );

    return qRgb( int_r, int_g, int_b );
}

QImage BCVDecoder::decodeImage( QDataStream& in, int width, int height, int index, QString fileName  ){

    //skip raw data
    int n = in.skipRawData(  (width*height*3)/2 );
    //printf("skip %d datas\n", n );

    int size = width*height;
    int halfSize = width*height/2;

    ifstream is ( fileName.toStdString() , std::ifstream::binary );
    unsigned char* Y = new unsigned char [size];
    unsigned char* UV = new unsigned char[halfSize];

    //compute offset
    int imageSize = size + halfSize;
    int offset = 256 + (index+1)*32 + index*imageSize; // BCV_VIDEO_HEADER size is 256, BCV_VIDEO_FRAME_HEADER is 32
    is.seekg( offset , is.beg );

    is.read ( (char*)Y, size );

    if (!is)
      std::cout << "error: only " << is.gcount() << " Y could be read";

    is.read ( (char*)UV, halfSize );

    if (!is)
      cout << "error: only " << is.gcount() << " UV could be read";

    is.close();

    //printf("index = %d\n", index );

    QImage img( width, height, QImage::Format_RGB32 );
    img.fill(QColor(Qt::white).rgb());

    for( int i=0, k=0, y=0, x=0; i< size; i+=2, k+=2 ){

        //i ->pointer of Y data
        //k ->pointer of UV data
        //x, y ->position of image

        int y1 = Y[i];
        int y2 = Y[i+1];
        int y3 = Y[i+width];
        int y4 = Y[i+width+1];

        int u = UV[k];
        int v = UV[k+1];
        u -= 128;
        v -= 128;

        img.setPixel( x, y, YUV2RGB( y1, u, v ) );
        img.setPixel( x, y+1, YUV2RGB( y2, u, v ) );
        img.setPixel( x+1, y, YUV2RGB(  y3, u, v ) );
        img.setPixel( x+1, y+1, YUV2RGB(  y4, u, v ) );


        if( i!=0 && ((i+2) % width) == 0 ){
            //cross a line
            i+= width;
        }

        x += 2;

        if( x == width ){
            x = 0;
            y += 2;
        }

    }

//    QString dir =  QDir::currentPath().append( "/output" + QString::number( index ) + ".png" );

//    bool result = img.save( dir );
//    if( !result )
//        printf("file save fail\n");

    delete[] Y;
    delete[] UV;

    return img;

}

void BCVDecoder::decodeFile( QString filePath ){

    QDir::setCurrent("/Users/Dasing/Desktop/build-Utility-Desktop_Qt_5_7_0_clang_64bit-Debug");
    filePath.remove(0, 7); //remove string "file://" , maybe be different on other platforms or differenct when compiled as application, should be tested
    qDebug() << "open file " << filePath << endl;
    QFile file(filePath);

    if ( !file.open( QIODevice::ReadOnly | QIODevice::Text ) ){
        qDebug() << "open " << filePath << "error" << endl;
        return;
    }
    file.setTextModeEnabled(false);

    QDataStream in(&file);

    _bcv_video_header fileHeader;
    QString result = decodeVideoHeader( in, &fileHeader );
    emit sendVideoHeaderInfo( result );

    for( int i=0; i < totalFrame; i++ ){
        _bcv_video_frame frameHeader;
        QString frameResult = decodeFrameHeader( in, &frameHeader );
        emit sendFrameHeaderInfo( frameResult );

        QImage img = decodeImage( in, width, height, i, filePath );
        emit sendImage( img );
    }

    emit finish();


}
