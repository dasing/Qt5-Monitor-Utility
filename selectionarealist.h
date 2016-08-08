#ifndef SELECTIONAREALIST_H
#define SELECTIONAREALIST_H
#include<QObject>
#include "selectionarea.h"
#include<QQmlListProperty>


class SelectionAreaList: public QObject
{
    Q_OBJECT
    Q_PROPERTY( QQmlListProperty<SelectionArea> areaList READ areaList )

public:
    SelectionAreaList();
    QQmlListProperty<SelectionArea> areaList();
    Q_INVOKABLE SelectionArea* area(int i);
    //Q_INVOKABLE SelectionArea area(int i);
    Q_INVOKABLE void listAllArea(int i);
    Q_INVOKABLE void addSelectionArea( int idx, int x, int y, int width, int height );
    Q_INVOKABLE void append( SelectionArea* newArea );
    //Q_INVOKABLE void append( int idx, int x, int y, int width, int height );
    Q_INVOKABLE int count();
    Q_INVOKABLE void clear();
    Q_INVOKABLE void removeItem( int idx );

private:
    QList<SelectionArea*> m_areaList;

};

#endif // SELECTIONAREALIST_H
