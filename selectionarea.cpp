#include "selectionarea.h"

SelectionArea::SelectionArea()
{
    m_index = -1;
    m_x = -1;
    m_y = -1;
    m_width = 0;
    m_height = 0;

}

int SelectionArea::index(){
    return m_index;
}

int SelectionArea::x(){
    return m_x;
}

int SelectionArea::y(){
    return m_y;
}

int SelectionArea::width(){
    return m_width;
}

int SelectionArea::height(){
    return m_height;
}

void SelectionArea::setSelectionArea( int index, int x, int y, int width, int height ){

    m_index = index;
    m_x = x;
    m_y = y;
    m_width = width;
    m_height = height;

}



