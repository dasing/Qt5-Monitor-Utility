TEMPLATE = app

QT += charts
QT += qml quick multimedia gui  widgets
CONFIG += c++11

SOURCES += main.cpp \
    framefilter.cpp \
    framefilterrunnable.cpp \
    analyzeresult.cpp \
    selectionarea.cpp \
    selectionarealist.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    framefilter.h \
    framefilterrunnable.h \
    analyzeresult.h \
    selectionarea.h \
    selectionarealist.h

#win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../../usr/local/Cellar/opencv/2.4.13/lib/release/ -lopencv_core.2.4.13
#else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../../usr/local/Cellar/opencv/2.4.13/lib/debug/ -lopencv_core.2.4.13
#else:unix: LIBS += -L$$PWD/../../../usr/local/Cellar/opencv/2.4.13/lib/ -lopencv_core.2.4.13

#INCLUDEPATH += $$PWD/../../../usr/local/Cellar/opencv/2.4.13/include
#DEPENDPATH += $$PWD/../../../usr/local/Cellar/opencv/2.4.13/include

#win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../../usr/local/Cellar/opencv/2.4.13/lib/release/ -lopencv_highgui.2.4.13
#else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../../usr/local/Cellar/opencv/2.4.13/lib/debug/ -lopencv_highgui.2.4.13
#else:unix: LIBS += -L$$PWD/../../../usr/local/Cellar/opencv/2.4.13/lib/ -lopencv_highgui.2.4.13

#INCLUDEPATH += $$PWD/../../../usr/local/Cellar/opencv/2.4.13/include
#DEPENDPATH += $$PWD/../../../usr/local/Cellar/opencv/2.4.13/include

#win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../../usr/local/Cellar/opencv/2.4.13/lib/release/ -lopencv_imgproc.2.4.13
#else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../../usr/local/Cellar/opencv/2.4.13/lib/debug/ -lopencv_imgproc.2.4.13
#else:unix: LIBS += -L$$PWD/../../../usr/local/Cellar/opencv/2.4.13/lib/ -lopencv_imgproc.2.4.13

#INCLUDEPATH += $$PWD/../../../usr/local/Cellar/opencv/2.4.13/include
#DEPENDPATH += $$PWD/../../../usr/local/Cellar/opencv/2.4.13/include
