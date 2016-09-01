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
    quint8 magic[BCV_MAGIC_STR_LEN];
    //sin >> magic;

    qDebug() << "magic = " << magic;


}
