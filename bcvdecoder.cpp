#include "bcvdecoder.h"
#include <QFile>

BCVDecoder::BCVDecoder(){
    printf("construct bcvdecoder");
    m_flag = 0;
}


void BCVDecoder::decodeFile(QString filePath){
    QFile file;
    file.open( QIODevice::ReadOnly );
}
