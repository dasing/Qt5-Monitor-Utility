#include "bcvencoderrunable.h"
#include "bcv_file.h"
#include<QDebug>
#include <QOpenGLFramebufferObject>
#include <QOpenGLContext>
#include <QOpenGLFunctions>
#include <QGLWidget>
#include <QDir>
#include <iostream>
#include <QDataStream>

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


quint32 turnRGB2int( int r, int g, int b ){

    quint32 val;
    val = r;
    val = ( val << 8 ) + g;
    val = ( val << 8 ) + b;

    return val;
}

QRgb convertYUVtoRGB( QDataStream& out, int y, int u, int v ){

    float r = ( (float)y + 1.402f*(float)v );
    float g = ( (float)y -  0.344f*(float)u - 0.714f*(float)v  );
    float b = ( (float)y + 1.772f*(float)u );

    int int_r = clamp( r, 0, 255 );
    int int_g = clamp( g, 0, 255 );
    int int_b = clamp( b, 0, 255 );

    //qint32 rgb = turnRGB2int( int_r, int_g, int_b );

    //out << rgb;

    return qRgb( int_r, int_g, int_b );
}

QVideoFrame bcvencoderrunable::run( QVideoFrame *input, const QVideoSurfaceFormat &surfaceFormat, RunFlags flags  ){

    Q_UNUSED(surfaceFormat);
    Q_UNUSED(flags);

    //initialize frame header
    QDataStream out(&m_bcvencoder->file);

    _bcv_video_frame frameHeader;
    frameHeader.index = (uint32_t)m_bcvencoder->m_totalFrame;
    frameHeader.hr_bpm = (int16_t)120;
    frameHeader.rr_bpm = (int16_t)60;
    frameHeader.interval = (uint32_t)10;
    frameHeader.lamda = (uint16_t) 3;
    frameHeader.eb_ts = (int8_t)0;
    memset( frameHeader.reserved, '0', sizeof(uint8_t) * 17 ); // 17 = 32 - 15 ( meaningful information )

    out << frameHeader.index;
    out << frameHeader.hr_bpm;
    out << frameHeader.rr_bpm;
    out << frameHeader.interval;
    out << frameHeader.lamda;
    out << frameHeader.eb_ts;
    out.writeRawData( (const char*)frameHeader.reserved, 17 );


    if( input->isValid() ){

        QOpenGLFunctions *f = QOpenGLContext::currentContext()->functions();

        /*If source of the videoOuput is Media, then the handleType will be openGL texture ID which cannot be mapped,
         * so should do more to process it, not finished yet*/
        if( input->handleType() == QAbstractVideoBuffer::GLTextureHandle ){
               qDebug() << "handle type is GLTextureHandle";
//             GLuint texture;
//             texture = input->handle().toUInt();
//             f->glBindTexture(GL_TEXTURE_2D, texture);

//             glBindTexture(GL_TEXTURE_2D, texture ); // Set as the current texture

//             glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
//             glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL);

//             QImage im("test.png");
//             QImage tex = QGLWidget::convertToGLFormat(im);

//             glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, tex.width(), tex.height(), 0, GL_RGBA, GL_UNSIGNED_BYTE, tex.bits());
//             glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
//             glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);

//             bool result = tex.save("test.png");
//             if( result )
//                 printf("file save successful\n");
//             else
//                 printf("file save fail\n");


        }else if( input->handleType() == QAbstractVideoBuffer::NoHandle ){


            bool mapResult = input->map(QAbstractVideoBuffer::ReadOnly);
            if( !mapResult )
                printf("map error\n");

            if( input->pixelFormat()  == QVideoFrame::Format_NV12 ){


                int size = input->width() * input->height();
                int width = input->width();
                int halfSize = size/2;

                unsigned char Y[size];
                unsigned char UV[halfSize];

                for( int i=0; i<size; i++ ){
                    Y[i] = input->bits(0)[i];
                }

                for( int i=0; i<halfSize; i++ ){
                    UV[i] = input->bits(1)[i];
                }

                out.writeRawData( (char*)Y, size );
                out.writeRawData( (char*)UV, halfSize );

                QImage img( input->width(), input->height(), QImage::Format_RGB32 );
                img.fill(QColor(Qt::white).rgb());


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

                    img.setPixel( x, y, convertYUVtoRGB( out, y1, u, v ) );
                    img.setPixel( x, y+1, convertYUVtoRGB( out, y2, u, v ) );
                    img.setPixel( x+1, y, convertYUVtoRGB( out, y3, u, v ) );
                    img.setPixel( x+1, y+1, convertYUVtoRGB( out, y4, u, v ) );

                    if( i!=0 && ((i+2) % input->width()) == 0 ){
                        //cross a line
                        i+= width;
                    }

                    x += 2;

                    if( x == width ){
                        x = 0;
                        y += 2;
                    }

                }

                QString dir =  QDir::currentPath().append( "/test" +QString::number( m_bcvencoder->m_totalFrame ) + ".png" );
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
        m_bcvencoder->m_totalFrame++;

        return *input;

    }


}
