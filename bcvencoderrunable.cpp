#include "bcvencoderrunable.h"
#include<QDebug>
#include <QOpenGLFramebufferObject>
#include <QOpenGLContext>
#include <QOpenGLFunctions>
#include <QGLWidget>

bcvencoderrunable::bcvencoderrunable( BCVEncoder* bcvencoder ): QVideoFilterRunnable()
{
    m_bcvencoder = bcvencoder;
}

QVideoFrame bcvencoderrunable::run( QVideoFrame *input, const QVideoSurfaceFormat &surfaceFormat, RunFlags flags  ){

    Q_UNUSED(surfaceFormat);
    Q_UNUSED(flags);

    //printf("count = %d\n", m_bcvencoder->count );
    //m_bcvencoder->count++;

    if( input->isValid() ){

        QOpenGLFunctions *f = QOpenGLContext::currentContext()->functions();

        qDebug() << "pixel format is " << input->pixelFormat();
        qDebug() << "handleType is " << input->handleType();


        /*If source of the videoOuput is Media, then the handleType will be openGL texture ID which cannot be mapped,
         * so should do more to process it, not finished yet*/
        if( input->handleType() == QAbstractVideoBuffer::GLTextureHandle ){

             GLuint texture;
             texture = input->handle().toUInt();
             f->glBindTexture(GL_TEXTURE_2D, texture);

             glBindTexture(GL_TEXTURE_2D, texture ); // Set as the current texture

             glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
             glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL);

             QImage im("test.png");
             QImage tex = QGLWidget::convertToGLFormat(im);

             glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, tex.width(), tex.height(), 0, GL_RGBA, GL_UNSIGNED_BYTE, tex.bits());
             glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
             glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);

             bool result = tex.save("test.png");
             if( result )
                 printf("file save successful\n");
             else
                 printf("file save fail\n");



        }else{

            //handle type is "NO HANDLE"

            bool mapResult = input->map(QAbstractVideoBuffer::ReadOnly);
            if( !mapResult )
                printf("map error\n");

            QImage::Format imageFormat = QVideoFrame::imageFormatFromPixelFormat( input->pixelFormat() );
            QImage img( input->width(), input->height(), imageFormat );
            qDebug() << "imageFormat is " << imageFormat;
            qDebug() << "img is " << img;

            qDebug() << "plane 0 is " << input->bytesPerLine(0) ;
            qDebug() << "plane 1 is " << input->bytesPerLine(1) ;
            qDebug() << "plane 2 is " << input->bytesPerLine(2) ;

            qDebug() << "plane 0 pointer is " << input->bits(0) ;
            qDebug() << "plane 1 pointer is " << input->bits(1) ;

            bool result = img.save("test.png");
            if( result )
                printf("file save successful\n");
            else
                printf("file save fail\n");

            fflush(stdout);



            if( input->isMapped() )
                input->unmap();


        }



//        bool mapResult = input->map(QAbstractVideoBuffer::ReadOnly);
//        if( mapResult )
//            printf("map succes\n");
//        else
//            printf("map error\n");


//        QImage::Format imageFormat = QVideoFrame::imageFormatFromPixelFormat( input->pixelFormat() );
//        QImage img( input->bits(), input->width(), input->height(), input->bytesPerLine(), imageFormat );

//        bool result = img.save("test.png");
//        if( result )
//            printf("file save successful\n");
//        else
//            printf("file save fail\n");

        fflush(stdout);

        //input->unmap();

        return *input;

    }


}
