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

void SelectionArea::setIndex( int i ){
    m_index = i;
}

void SelectionArea::setX( int x ){
    m_x = x;
}

void SelectionArea::setY( int y ){
    m_y = y;
}

void SelectionArea::setWidth( int w ){
    m_width = w;
}

void SelectionArea::setHeight( int h ){
    m_height = h;
}

void SelectionArea::setSelectionArea( int index, int x, int y, int width, int height ){

    m_index = index;
    m_x = x;
    m_y = y;
    m_width = width;
    m_height = height;

}



