#ifndef BCVENCODER_H
#define BCVENCODER_H
#include<QAbstractVideoFilter>
#include <QFile>

using namespace std;

class BCVEncoder: public QAbstractVideoFilter
{
    Q_OBJECT

public:
    BCVEncoder();
    QVideoFilterRunnable *createFilterRunnable();
    void updateTotalFrames();
    Q_INVOKABLE void initializeBCVEncoder();
    Q_INVOKABLE void resetBCVEncoder();
    QFile file;


    friend class bcvencoderrunable;


signals:
    void finished();

private:
    int m_totalFrame;




};

#endif // BCVENCODER_H
