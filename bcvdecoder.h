#ifndef BCVDECODER_H
#define BCVDECODER_H
#include <QObject>

using namespace std;

class BCVDecoder: public QObject
{
    Q_OBJECT

public:
    BCVDecoder();
    Q_INVOKABLE void decodeFile( QString filePath );

private:
    int m_flag;
};

#endif // BCVDECODER_H
