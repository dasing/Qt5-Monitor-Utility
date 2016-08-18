#ifndef FRAMEFILTER_H
#define FRAMEFILTER_H
#include<QAbstractVideoFilter>
#include <QDebug>
#include "selectionarea.h"

class FrameFilter: public QAbstractVideoFilter{

    Q_OBJECT
    Q_PROPERTY( int x_start READ x_start WRITE setX_start )
    Q_PROPERTY( int updateFlag READ updateFlag WRITE setUpdateFlag )
    Q_PROPERTY( QList<QString> rectList READ rectList WRITE setRectList )
public:


    FrameFilter();
    QVideoFilterRunnable *createFilterRunnable();
    int x_start() const { return m_xStart; }
    int updateFlag() const { return m_updateFlag; }
    void setRectList( QList<QString> newString );
    void updateAreaList();
    void showAreaList();
    QList<QString> rectList() { return m_rectList; }
    Q_INVOKABLE void updateAreaList( QList<SelectionArea*> newList );
    Q_INVOKABLE void setX_start( int newValue ) { qDebug() << "in setX_start" ; m_xStart = newValue; }
    Q_INVOKABLE void setUpdateFlag( int newValue ) { m_updateFlag = newValue; }
    Q_INVOKABLE void listRectList();
    Q_INVOKABLE void addRect( QString newString );
    Q_INVOKABLE void removeData( int index );
    Q_INVOKABLE void clearData();

    QList<SelectionArea*> arealist;



signals:
    void finished( QObject *res );

private:

    int m_xStart;
    int m_updateFlag;
    QList<QString> m_rectList; //Question : how to free QString's memory?

};

#endif // FRAMEFILTER_H
