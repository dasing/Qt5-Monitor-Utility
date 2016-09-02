#include "bcvdecoder.h"
#include "bcv_file.h"
#include <QFile>
#include <iostream>
#include <QDebug>
#include <QDir>
#include <QDataStream>
#include <cstring>


#define BCV_MAGIC_STR_LEN		(8)

BCVDecoder::BCVDecoder(){
    //printf("construct bcvdecoder");
    m_flag = 0;
}

void decodeVideoHeader( QDataStream& in, _bcv_video_header* header ){

    in.readRawData( (char*)header->magic, 8 );
    in >> header->version;
    in >> header->width;
    in >> header->height;
    in >> header->fps;
    in >> header->pix_fmt;
    in >> header->total_frames;
    in >> header->date_year;
    in >> header->date_mmdd;
    in >> header->date_hhmin;
    in >> header->date_sec;
    in >> header->nir_baseline;
    in >> header->nir_channels;
    in.readRawData( (char*)header->nir_lambda, 214 ); // 214 = 256 - 42


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

}


void BCVDecoder::decodeFile( QString filePath ){


    QDir::setCurrent("/Users/Dasing/Desktop/build-Utility-Desktop_Qt_5_7_0_clang_64bit-Debug");
    filePath.remove(0, 7); //remove string "file://"
    qDebug() << "open file " << filePath << endl;
    QFile file(filePath);

    if ( !file.open( QIODevice::ReadOnly | QIODevice::Text ) ){
        qDebug() << "open " << filePath << "error" << endl;
        return;
    }


    QDataStream in(&file);
    _bcv_video_header fileHeader;
    decodeVideoHeader( in, &fileHeader );


}
