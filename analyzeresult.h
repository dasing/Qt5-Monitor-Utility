#ifndef ANALYZERESULT_H
#define ANALYZERESULT_H
#include <QObject>


class AnalyzeResult : public QObject
{
    Q_OBJECT
    Q_PROPERTY( double brightness READ brightness WRITE setBrightness )
    Q_PROPERTY( double brightness2 READ brightness2 WRITE setBrightness2 )


public:
    AnalyzeResult();
    double brightness() const { return m_brightness; }
    void setBrightness( double value ) { m_brightness = value; }
    double brightness2() const { return m_brightness2; }
    void setBrightness2( double value ) { m_brightness2 = value; }

private:
    double m_brightness;
    double m_brightness2;

};

#endif // ANALYZERESULT_H
