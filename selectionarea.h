#ifndef SELECTIONAREA_H
#define SELECTIONAREA_H

#include <QObject>

class SelectionArea : public QObject
{
    Q_OBJECT
    Q_PROPERTY( int index READ index )
    Q_PROPERTY( int x READ x )
    Q_PROPERTY( int y READ y )
    Q_PROPERTY( int width READ width )
    Q_PROPERTY( int height READ height )

public:
    SelectionArea();
    int index();
    int x();
    int y();
    int width();
    int height();

    //int shape;
    void setSelectionArea( int index, int x, int y, int width, int height );

private:
    int m_index;
    int m_x;
    int m_y;
    int m_width;
    int m_height;
    //int m_shape; //circle or rectangle
};

#endif // SELECTIONAREA_H
