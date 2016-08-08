#include "framefilter.h"
#include "framefilterrunnable.h"
#include<QAbstractVideoFilter>

FrameFilter::FrameFilter(){
    m_xStart = -1;

   // QList<SelectionArea> tmpList =
   // printf("arealist size = %d \n", arealist.size() );
}


QVideoFilterRunnable* FrameFilter::createFilterRunnable(){

    return new FrameFilterRunnable(this);
}

void FrameFilter::updateAreaList( QList<SelectionArea*> newList ){

    printf("in updateAreaList");

    printf("updatelist Size = %d\n", newList.size() );
    arealist.clear();
    for( int i=0; i<newList.size(); i++ ){
        arealist.append( newList.at(i) );
    }

}

void FrameFilter::listRectList(){

    //printf("in C++ , listRectList\n");
    qDebug() << "in C++ , listRectList";
    for(  int i=0; i<m_rectList.size(); i++ ){

        //printf("%s\n", m_rectList.at(i) );
        qDebug() << m_rectList.at(i);
    }

}

void FrameFilter::addRect( QString newString ){

    m_rectList.append( newString );
}

void FrameFilter::setRectList(QList<QString> newString){

   //qDebug() << "in setRectList";
   m_rectList = newString;

   updateAreaList();
   showAreaList();
}

void FrameFilter::updateAreaList(){

    arealist.clear();

    for( int i=0; i<m_rectList.length(); i++ ){

        QString str = m_rectList.at(i);
        QStringList list = str.split(';', QString::SkipEmptyParts );

        qDebug() << "index = " << list[0] << " x = " << list[1] << " y = " << list[2] << " width = " << list[3] << " height = " << list[4];

        SelectionArea* newArea = new SelectionArea;
        newArea->setSelectionArea( list[0].toInt(), list[1].toInt(), list[2].toInt(), list[3].toInt(), list[4].toInt() );
        arealist.append( newArea );


    }
}

void FrameFilter::showAreaList(){


    printf("in showAreaList\n");
    for( int i=0; i<arealist.size(); i++ ){

        printf("index = %d, x = %d, y = %d, width = %d, height = %d\n", arealist.at(i)->index(), arealist.at(i)->x(), arealist.at(i)->y(), arealist.at(i)->width(), arealist.at(i)->height() );
    }
}
