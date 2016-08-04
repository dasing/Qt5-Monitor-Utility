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

void SelectionAreaList::listAllArea(){

    printf("---------listAllArea---------\n");


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
