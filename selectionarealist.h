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
    SelectionArea* area(int i);
    Q_INVOKABLE void listAllArea();
    Q_INVOKABLE void addSelectionArea( int idx, int x, int y, int width, int height );

private:
    QList<SelectionArea*> m_areaList;

};

#endif // SELECTIONAREALIST_H
