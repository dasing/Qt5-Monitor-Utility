#ifndef FRAMEFILTER_H
#define FRAMEFILTER_H
#include<QAbstractVideoFilter>
#include <QDebug>

class FrameFilter: public QAbstractVideoFilter{

    Q_OBJECT
    Q_PROPERTY( int x_start READ x_start WRITE setX_start )

public:
    FrameFilter();
    QVideoFilterRunnable *createFilterRunnable();
    int x_start() const { return m_xStart; }
    Q_INVOKABLE void setX_start( int newValue ) { qDebug() << "in setX_start" ; m_xStart = newValue; }
signals:
    void finished(QObject *res );

private:
    int m_xStart;
};

#endif // FRAMEFILTER_H
