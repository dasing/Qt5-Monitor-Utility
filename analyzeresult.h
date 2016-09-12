#ifndef ANALYZERESULT_H
#define ANALYZERESULT_H
#include <QObject>


class AnalyzeResult : public QObject
{
    Q_OBJECT
    Q_PROPERTY( QList<int> x_result READ x_result WRITE setX_result )
    Q_PROPERTY( QList<int> y_result READ y_result WRITE setY_result )


public:
    AnalyzeResult();
    QList<int> x_result() { return m_xResult; }
    QList<int> y_result() { return m_yResult; }
    void setX_result( QList<int> newList ) { m_xResult = newList; }
    void setY_result( QList<int> newList ) { m_yResult = newList; }

    friend class FrameFilterRunnable;


private:
    QList<int> m_xResult;
    QList<int> m_yResult;

};

#endif // ANALYZERESULT_H
