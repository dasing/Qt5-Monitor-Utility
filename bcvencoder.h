#ifndef BCVENCODER_H
#define BCVENCODER_H
#include<QAbstractVideoFilter>
#include <QFile>
#include "bcv_file.h"

using namespace std;

class BCVEncoder: public QAbstractVideoFilter
{
    Q_OBJECT

public:
    BCVEncoder();
    QVideoFilterRunnable *createFilterRunnable();
    void updateTotalFrames();
    void writeFiles();
    void resetMemory();
    Q_INVOKABLE void initializeBCVEncoder();
    Q_INVOKABLE void resetBCVEncoder();
    QFile file;


    friend class bcvencoderrunable;


signals:
    void finished();

private:
    int m_totalFrame;
    QList<_bcv_video_frame> frameHeaderList;
    QList<unsigned char*> YList;
    QList<unsigned char*> UVList;

};

#endif // BCVENCODER_H
