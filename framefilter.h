#ifndef FRAMEFILTER_H
#define FRAMEFILTER_H
#include<QAbstractVideoFilter>
#include <QDebug>

class FrameFilter: public QAbstractVideoFilter{

    Q_OBJECT
    Q_PROPERTY( int x_start READ x_start WRITE setX_start )
    Q_PROPERTY( int updateFlag READ updateFlag WRITE setUpdateFlag )

public:
    FrameFilter();
    QVideoFilterRunnable *createFilterRunnable();
    int x_start() const { return m_xStart; }
    int updateFlag() const { return m_updateFlag; }
    Q_INVOKABLE void setX_start( int newValue ) { qDebug() << "in setX_start" ; m_xStart = newValue; }
    Q_INVOKABLE void setUpdateFlag( int newValue ) { m_updateFlag = newValue; }
signals:
    void finished(QObject *res );

private:
    int m_xStart;
    int m_updateFlag;
};

#endif // FRAMEFILTER_H
