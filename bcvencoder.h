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
    Q_INVOKABLE void initializeBCVEncoder();
    Q_INVOKABLE void resetBCVEncoder();

    int count;
    QFile file;


signals:
    void finished();


};

#endif // BCVENCODER_H
