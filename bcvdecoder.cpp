#include "bcvdecoder.h"
#include <QFile>
#include <iostream>
#include <QDebug>
#include <QDir>
#include <QDataStream>


#define BCV_MAGIC_STR_LEN		(8)

BCVDecoder::BCVDecoder(){
    //printf("construct bcvdecoder");
    m_flag = 0;
}


void BCVDecoder::decodeFile( QString filePath ){


    QDir::setCurrent("/Users/Dasing/Desktop/build-Utility-Desktop_Qt_5_7_0_clang_64bit-Debug");
    filePath.remove(0, 7); //remove "file://"
    qDebug() << "open file " << filePath << endl;
    QFile file(filePath);

    if ( !file.open( QIODevice::ReadOnly | QIODevice::Text ) ){
        qDebug() << "open " << filePath << "error" << endl;
        return;
    }

    QDataStream in(&file);
    char magic[BCV_MAGIC_STR_LEN];
    char version[4];

    int result = in.readRawData( magic, 1 );
    int result2 = in.readRawData( version, 4 );
    printf("magic = %s\n", reinterpret_cast<uint8_t*>(magic) );
    printf("version = %d\n", reinterpret_cast<uint32_t*>(version));
    printf("result = %d\n", result );
    //qDebug() << "magic = " << magic;


}
