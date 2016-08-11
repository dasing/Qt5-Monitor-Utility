#ifndef ANALYZERESULT_H
#define ANALYZERESULT_H
#include <QObject>


class AnalyzeResult : public QObject
{
    Q_OBJECT
    Q_PROPERTY( double brightness READ brightness WRITE setBrightness )
    Q_PROPERTY( double brightness2 READ brightness2 WRITE setBrightness2 )
    Q_PROPERTY( QList<int> x_result READ x_result WRITE setX_result )
    Q_PROPERTY( QList<int> y_result READ y_result WRITE setY_result )


public:
    AnalyzeResult();
    double brightness() const { return m_brightness; }
    void setBrightness( double value ) { m_brightness = value; }
    double brightness2() const { return m_brightness2; }
    void setBrightness2( double value ) { m_brightness2 = value; }
    QList<int> x_result() { return m_xResult; }
    QList<int> y_result() { return m_yResult; }
    void setX_result( QList<int> newList ) { m_xResult = newList; }
    void setY_result( QList<int> newList ) { m_yResult = newList; }

    friend class FrameFilterRunnable;


private:
    double m_brightness;
    double m_brightness2;

    QList<int> m_xResult;
    QList<int> m_yResult;

};

#endif // ANALYZERESULT_H
