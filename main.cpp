#include <QApplication>
#include <QQmlApplicationEngine>
#include<QAbstractVideoFilter>
#include <QCamera>
#include <QQuickItem>
#include <QQuickView>
#include <QQmlContext>
#include <QObject>
#include "framefilter.h"
#include "framefilterrunnable.h"
#include "analyzeresult.h"
#include "bcvencoder.h"
#include "bcvdecoder.h"
#include "imageprovider.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<FrameFilter>("qmlvideofilter", 1, 0, "FrameFilter" );
    qmlRegisterType<AnalyzeResult>("qmlvideofilter", 1, 0, "AnalyzeResult");
    qmlRegisterType<BCVEncoder>("qmlbcvencoder", 1, 0, "BCVEncoder");
    qmlRegisterType<BCVDecoder>("qmlbcvdecoder", 1, 0, "BCVDecoder");

    ImageProvider* ImgProvider = new ImageProvider();
    engine.rootContext()->setContextProperty("ProviderImg", ImgProvider );
    engine.addImageProvider( "provider", ImgProvider );
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    QQuickView view;
    view.setSource(QUrl("qrc:/main.qml"));
    view.show();

    return app.exec();
}
