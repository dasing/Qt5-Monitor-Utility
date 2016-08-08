#include "selectionarealist.h"
#include "selectionarea.h"

SelectionAreaList::SelectionAreaList()
{
    m_areaList.empty();
}

QQmlListProperty<SelectionArea> SelectionAreaList::areaList(){

    return QQmlListProperty<SelectionArea>( this, m_areaList );

}

SelectionArea* SelectionAreaList::area(int i){
    return m_areaList.at(i);
}

//SelectionArea SelectionAreaList::area( int i ){

//    SelectionArea newArea;
//    newArea.m_index = m_areaList.at(i)->index();
//    newArea.m_x = m_areaList.at(i)->x();
//    newArea.m_y = m_areaList.at(i)->y();
//    newArea.m_width = m_areaList.at(i)->width();
//    newArea.m_height = m_areaList.at(i)->height();

//    return newArea;
//}

void SelectionAreaList::append( SelectionArea* area ){

    SelectionArea* newArea = new SelectionArea;
    //newArea->setSelectionArea( area->index(), area->x(), area->y(), area->width(), area->height() );
    newArea->setSelectionArea( 1, 1, 1, 1, 1 );
    m_areaList.append( newArea );

    //printf("after append : index = %d, x = %d, y = %d, width = %d, height = %d\n", area->index(), area->x(), area->y(), area->width(), area->height() );
}

//void SelectionAreaList::append( int index, int x, int y, int width, int height ){

//        SelectionArea* newArea = new SelectionArea;
//        newArea->setSelectionArea( index, x, y, width, height );
//        //newArea->setSelectionArea( 1, 1, 1, 1, 1 );
//        m_areaList.append( newArea );
//}

int SelectionAreaList::count(){
    return m_areaList.size();
}


void SelectionAreaList::listAllArea( int i ){

    printf("---------listAllArea %d ---------\n", i);


    for( int i=0; i< m_areaList.size(); i++ ){
        printf("index = %d\n", m_areaList.at(i)->index());
        printf("x = %d, y = %d, width = %d, height= %d\n", m_areaList.at(i)->x(), m_areaList.at(i)->y(), m_areaList.at(i)->width(), m_areaList.at(i)->height() );
    }

    fflush(stdout);
}



void SelectionAreaList::addSelectionArea( int idx, int x, int y, int width, int height ){

    SelectionArea* newArea = new SelectionArea;
    newArea->setSelectionArea( idx, x, y, width, height );

    m_areaList.append( newArea );

}

void SelectionAreaList::removeItem( int idx ) {

    m_areaList.removeAt( idx );
}

void SelectionAreaList::clear(){
    m_areaList.empty();
}

