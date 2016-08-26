#include "bcvencoder.h"
#include "bcvencoderrunable.h"
#include <QAbstractVideoFilter>

BCVEncoder::BCVEncoder()
{
    printf("construct bcvencoder\n");
    count = 0;
}

QVideoFilterRunnable* BCVEncoder::createFilterRunnable(){

    return new bcvencoderrunable(this);
}

