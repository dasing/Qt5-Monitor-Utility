#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H

#include <QObject>
#include <QQuickImageProvider>

class ImageProvider : public QObject, public QQuickImageProvider
{
    Q_OBJECT

public:
    ImageProvider();
    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize);

public slots:
    void carryImage( QImage image );
    void reset();


private:
    QList<QImage> imgList;

};

#endif // IMAGEPROVIDER_H
