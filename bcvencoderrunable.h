#ifndef BCVENCODERRUNABLE_H
#define BCVENCODERRUNABLE_H
#include<QAbstractVideoFilter>
#include "bcvencoder.h"


class bcvencoderrunable : public QVideoFilterRunnable
{
public:
    bcvencoderrunable( BCVEncoder *bcvencoder );
    QVideoFrame run( QVideoFrame *input, const QVideoSurfaceFormat &surfaceFormat, RunFlags flags  );

private:
    BCVEncoder* m_bcvencoder;

};

#endif // BCVENCODERRUNABLE_H
