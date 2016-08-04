#include "framefilter.h"
#include "framefilterrunnable.h"
#include<QAbstractVideoFilter>

FrameFilter::FrameFilter(){
    m_xStart = -1;
}


QVideoFilterRunnable* FrameFilter::createFilterRunnable(){

    return new FrameFilterRunnable(this);
}
