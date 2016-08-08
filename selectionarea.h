#ifndef SELECTIONAREA_H
#define SELECTIONAREA_H

#include <QObject>

class SelectionArea : public QObject
{
    Q_OBJECT
    Q_PROPERTY( int index READ index WRITE setIndex )
    Q_PROPERTY( int x READ x WRITE setX )
    Q_PROPERTY( int y READ y WRITE setY )
    Q_PROPERTY( int width READ width WRITE setWidth )
    Q_PROPERTY( int height READ height WRITE setHeight )

public:
    SelectionArea();
    int index();
    int x();
    int y();
    int width();
    int height();

    //int shape;
    void setSelectionArea( int index, int x, int y, int width, int height );
    void setIndex( int i );
    void setX( int x );
    void setY( int y );
    void setWidth( int w );
    void setHeight( int h );


    int m_index;
    int m_x;
    int m_y;
    int m_width;
    int m_height;
    //int m_shape; //circle or rectangle
};

#endif // SELECTIONAREA_H
