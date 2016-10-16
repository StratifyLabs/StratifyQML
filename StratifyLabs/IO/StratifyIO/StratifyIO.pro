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

DEFINES += __link

SOURCES += \
    Data.cpp \
    Helper.cpp \
    AppIO.cpp \
    ConnectionIO.cpp \
    KernelIO.cpp \
    NotificationIO.cpp \
    TerminalIO.cpp \
    AppData.cpp \
    IO.cpp \
    HardwareData.cpp \
    UserData.cpp \
    DeviceData.cpp \
    StratifyObject.cpp \
    FirebaseDataService.cpp \
    DataService.cpp \
    StratifyPrompt.cpp \
    TraceEvent.cpp
HEADERS += StratifyIO.h \
    Data.h \
    LinkDriver.h \
    Worker.h \
    Helper.h \
    AppIO.h \
    ConnectionIO.h \
    KernelIO.h \
    TerminalIO.h \
    AppData.h \
    IO.h \
    HardwareData.h \
    DeviceData.h \
    UserData.h \
    StratifyData.h \
    StratifyObject.h \
    DataService.h \
    FirebaseDataService.h \
    NotificationIO.h \
    StratifyPrompt.h \
    TraceEvent.h

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

