#-------------------------------------------------
#
# Project created by QtCreator 2016-10-07T11:12:08
#
#-------------------------------------------------

QT       += network serialport
QT       -= gui

TARGET = StratifyIO
TEMPLATE = lib
CONFIG += staticlib

DEFINES += __link __StratifyOS__

SOURCES += \
    App.cpp \
    User.cpp \
    Hardware.cpp \
    Device.cpp \
    Data.cpp \
    DataFirebase.cpp \
    AppManager.cpp \
    DeviceManager.cpp \
    KernelManager.cpp \
    NotificationManager.cpp \
    TerminalManager.cpp \
    ConnectionManager.cpp \
    Helper.cpp
HEADERS += StratifyIO.h \
    App.h \
    User.h \
    Hardware.h \
    Device.h \
    Data.h \
    DataFirebase.h \
    AppManager.h \
    DeviceManager.h \
    KernelManager.h \
    NotificationManager.h \
    TerminalManager.h \
    ConnectionManager.h \
    LinkDriver.h \
    Worker.h \
    Helper.h

INSTALL_HEADERS.files = $$HEADERS

macx {
	target.path = /Applications/StratifyLabs-SDK/Tools/gcc/lib
	INSTALL_HEADERS.path = /Applications/StratifyLabs-SDK/Tools/gcc/include/StratifyIO
}

unix {
    INSTALLS += target
	INSTALLS += INSTALL_HEADERS
	TOOLSPATH = /Applications/StratifyLabs-SDK/Tools/gcc
}

win32 {
	TOOLSPATH = c:/StratifyLabs-SDK/Tools/gcc
}

INCLUDEPATH += $$TOOLSPATH/include

