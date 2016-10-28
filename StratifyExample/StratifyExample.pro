TEMPLATE = app

QT += qml quick
CONFIG += c++11

SOURCES += main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)


HEADERS += \



INCLUDEPATH += $$PWD/../StratifyLabs/IO

LIBS += -L$$PWD/../StratifyLabs/IO/build-StratifyData-Desktop_Qt_5_7_0_clang_64bit-Debug -lStratifyData

