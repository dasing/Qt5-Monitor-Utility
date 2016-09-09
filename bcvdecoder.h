#ifndef BCVDECODER_H
#define BCVDECODER_H
#include <QObject>
#include <QImage>
#include "bcv_file.h"
#include "imageprovider.h"

using namespace std;

class BCVDecoder: public QObject
{
    Q_OBJECT

public:
    BCVDecoder();
    QString decodeVideoHeader( QDataStream& in, _bcv_video_header* header );
    QString decodeFrameHeader( QDataStream& in, _bcv_video_frame* header );
    QImage decodeImage( QDataStream& in, int width, int height, int i, QString fileName );
    Q_INVOKABLE void decodeFile( QString filePath );


signals:
    void sendVideoHeaderInfo( QString videoHeaderStruct );
    void sendFrameHeaderInfo( QString frameHeaderStruct );
    void sendImage( QImage image );
    void finish();

private:
    ImageProvider imgProvider;
    int totalFrame;
    int width;
    int height;

};

#endif // BCVDECODER_H
