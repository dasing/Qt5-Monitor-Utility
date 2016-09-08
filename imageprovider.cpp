#include "imageprovider.h"
#include <QDebug>

ImageProvider::ImageProvider(): QQuickImageProvider(QQuickImageProvider::Image)
{

}

QImage ImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize){

    return imgList.at( id.toInt() );
}

void ImageProvider::carryImage(QImage image){

    imgList.append(image);

}

