#ifndef FRAMEFILTERRUNNABLE_H
#define FRAMEFILTERRUNNABLE_H
#include<QAbstractVideoFilter>
#include "framefilter.h"


class FrameFilterRunnable: public QVideoFilterRunnable{

public:
    FrameFilterRunnable( FrameFilter *filter );

    QVideoFrame run( QVideoFrame *input, const QVideoSurfaceFormat &surfaceFormat, RunFlags flags );


private:
    FrameFilter* m_filter;

};


#endif // FRAMEFILTERRUNNABLE_H
