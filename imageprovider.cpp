#include "imageprovider.h"
#include <QDebug>

ImageProvider::ImageProvider(): QQuickImageProvider(QQuickImageProvider::Image)
{

}

QImage ImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize){

    if( img.isNull() ){
        qDebug() << "image transport error";
    }

    return img;
}

void ImageProvider::carryImage(QImage image){

    if( image.isNull() )
        qDebug() << "in carry Image, image transport error";

    img = image;
}
