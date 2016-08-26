#ifndef BCVENCODER_H
#define BCVENCODER_H
#include<QAbstractVideoFilter>

class BCVEncoder: public QAbstractVideoFilter
{
    Q_OBJECT

public:
    BCVEncoder();
    QVideoFilterRunnable *createFilterRunnable();
    int count;

signals:
    void finished();



};

#endif // BCVENCODER_H
