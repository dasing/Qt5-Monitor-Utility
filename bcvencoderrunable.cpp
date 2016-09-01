#include "bcvencoderrunable.h"
#include "bcv_file.h"
#include<QDebug>
#include <QOpenGLFramebufferObject>
#include <QOpenGLContext>
#include <QOpenGLFunctions>
#include <QGLWidget>
#include <QDir>

using namespace std;

bcvencoderrunable::bcvencoderrunable( BCVEncoder* bcvencoder ): QVideoFilterRunnable()
{
    m_bcvencoder = bcvencoder;
}

float clamp( float value, int lv, int hv ){

    if( value < lv )
        value = lv;
    else if( value > hv )
        value = hv;

    return value;
}

QRgb convertYUVtoRGB( int y, int u, int v ){

    float r = ( (float)y + 1.402f*(float)v );
    float g = ( (float)y -  0.344f*(float)u - 0.714f*(float)v  );
    float b = ( (float)y + 1.772f*(float)u );

    int int_r = clamp( r, 0, 255 );
    int int_g = clamp( g, 0, 255 );
    int int_b = clamp( b, 0, 255 );

    return qRgb( int_r, int_g, int_b );
}

QVideoFrame bcvencoderrunable::run( QVideoFrame *input, const QVideoSurfaceFormat &surfaceFormat, RunFlags flags  ){

    Q_UNUSED(surfaceFormat);
    Q_UNUSED(flags);

    //initialize frame header
    QDataStream out(&m_bcvencoder->file);
    _bcv_video_frame frameHeader;
    frameHeader.index = (uint32_t)m_bcvencoder->count;
    frameHeader.hr_bpm = (int16_t)120;
    frameHeader.rr_bpm = (int16_t)60;
    frameHeader.interval = (uint32_t)10;
    frameHeader.lamda = (uint16_t) 3;
    frameHeader.eb_ts = (int8_t)0;

    out << frameHeader.index;
    out << frameHeader.hr_bpm;
    out << frameHeader.rr_bpm;
    out << frameHeader.interval;
    out << frameHeader.lamda;
    out << frameHeader.eb_ts;
    out << '\n';

    if( input->isValid() ){

        QOpenGLFunctions *f = QOpenGLContext::currentContext()->functions();

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


        }else if( input->handleType() == QAbstractVideoBuffer::NoHandle ){


            bool mapResult = input->map(QAbstractVideoBuffer::ReadOnly);
            if( !mapResult )
                printf("map error\n");

            if( input->pixelFormat()  == QVideoFrame::Format_NV12 ){

                QImage img( input->width(), input->height(), QImage::Format_ARGB32_Premultiplied );
                img.fill(QColor(Qt::white).rgb());

                int size = input->width() * input->height();
                int width = input->width();
//                qDebug() << "width = " << img.width();
//                qDebug() << "height = " << img.height();
//                qDebug() << "size = " << size;
                int count = 0;
                for( int i=0, k=0, y=0, x=0; i< size; i+=2, k+=2 ){

                    //i ->pointer of Y data
                    //k ->pointer of UV data
                    //x, y ->position of image

                    int y1 = input->bits(0)[i];
                    int y2 = input->bits(0)[i+1];
                    int y3 = input->bits(0)[i+input->width()];
                    int y4 = input->bits(0)[i+input->width()+1];

                    int u = input->bits(1)[k];
                    int v = input->bits(1)[k+1];
                    u -= 128;
                    v -= 128;


                    img.setPixel( x, y, convertYUVtoRGB( y1, u, v ) );
                    img.setPixel( x, y+1, convertYUVtoRGB( y2, u, v ) );
                    img.setPixel( x+1, y, convertYUVtoRGB( y3, u, v ) );
                    img.setPixel( x+1, y+1, convertYUVtoRGB( y4, u, v ) );

                    out << convertYUVtoRGB( y1, u, v );
                    out << convertYUVtoRGB( y2, u, v );
                    out << convertYUVtoRGB( y3, u, v );
                    out << convertYUVtoRGB( y4, u, v );

                    if( i!=0 && ((i+2) % input->width()) == 0 ){
                        //cross a line
                        i+= width;
                    }

                    x += 2;
                    count++;
                    if( x == width ){
                        x = 0;
                        y += 2;
                    }

                }

                QString dir =  QDir::currentPath().append( "/test" +QString::number( m_bcvencoder->count) + ".png" );
                //qDebug() << "save dir = " << dir;

                bool result = img.save( dir );
                if( !result )
                    printf("file save fail\n");

                fflush(stdout);

                if( input->isMapped() )
                    input->unmap();


            }else{
                qDebug() << "non support image format " << input->pixelFormat();
            }


        }else{
            qDebug() << " non supprt handle type " << input->handleType();
        }


        fflush(stdout);

        out << '\n'; //end symbol
        //printf("count = %d\n", m_bcvencoder->count );
        m_bcvencoder->count++;

        return *input;

    }


}
