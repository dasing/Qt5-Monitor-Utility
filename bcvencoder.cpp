#include "bcvencoder.h"
#include "bcvencoderrunable.h"
#include "bcv_file.h"
#include <QAbstractVideoFilter>
#include <iostream>
#include <QByteArray>
#include <QDebug>
#include <QDir>

using namespace std;

BCVEncoder::BCVEncoder()
{
    printf("construct bcvencoder\n");
    count = 0;
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
    QDir::setCurrent("/Users/Dasing/Desktop/build-Utility-Desktop_Qt_5_7_0_clang_64bit-Debug");
    file.open(QIODevice::WriteOnly);

    QDataStream out(&file);

    //Initialize Parameters
    count = 0; //parameter which notes for Image number stored in bcvfile

    _bcv_video_header header;
    //strcat( header.magic, "biotrump" );
    memcpy( header.magic,"biotrump", sizeof(uint8_t) *8 );  
    header.version = (uint32_t)1;
    header.width = (uint16_t)640;
    header.height = (uint16_t)480;
    header.fps = 300.1;
    header.pix_fmt = (uint32_t)1; //ARGB8888
    header.total_frames = (uint16_t)0;
    header.date_year = (int16_t)year;
    header.date_mmdd = ( mon << 8 ) + day;
    header.date_hhmin = ( hour << 8 ) + min;
    header.date_sec = (int16_t) sec;

    //write dataStructure to file
    out << header.magic;
    qDebug() << "currSize = " << file.size();
    out << header.version;
    out << header.width;
    out << header.height;
    out << header.fps;
    out << header.pix_fmt;
    out << header.total_frames;
    out << header.date_year;
    out << header.date_mmdd;
    out << header.date_hhmin;
    out << header.date_sec;
    out << '\n'; //end symbol

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

}

void BCVEncoder::resetBCVEncoder(){

    //TO DO: restore totalFrames


    //reset parameter and close file
    count = 0;
    file.close();
}

