#ifndef BCVDECODER_H
#define BCVDECODER_H
#include <QObject>

using namespace std;

class BCVDecoder: public QObject
{
    Q_OBJECT

public:
    BCVDecoder();
    Q_INVOKABLE void decodeFile( QString filePath );

signals:
    void sendVideoHeaderInfo( QString videoHeaderStruct );
//    void sendFrameHeaderInfo( QString frameHeaderStruct );
//    void sendImage( QImage image );

};

#endif // BCVDECODER_H
