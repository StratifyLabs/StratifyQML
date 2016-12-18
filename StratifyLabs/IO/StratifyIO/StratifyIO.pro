#-------------------------------------------------
#
# Project created by QtCreator 2016-10-07T11:12:08
#
#-------------------------------------------------

QT       += core network serialport
QT       -= gui

TARGET = StratifyIO
TEMPLATE = lib
CONFIG += staticlib

DEFINES += __link

SOURCES += \
    Helper.cpp \
    AppIO.cpp \
    ConnectionIO.cpp \
    KernelIO.cpp \
    TerminalIO.cpp \
    IO.cpp \
    TraceEvent.cpp \
    PortIO.cpp \
    Link.cpp
HEADERS += StratifyIO.h \
    LinkDriver.h \
    Helper.h \
    AppIO.h \
    ConnectionIO.h \
    KernelIO.h \
    TerminalIO.h \
	IO.h \
    TraceEvent.h \
    PortIO.h \
    Link.h \
    SLinkDriver.h

INSTALL_HEADERS.files = $$HEADERS

macx:INSTALLPATH = /Applications/StratifyLabs-SDK/Tools/gcc
win32:INSTALLPATH = c:/StratifyLabs-SDK/Tools/gcc

target.path = $$INSTALLPATH/lib
INSTALL_HEADERS.path = $$INSTALLPATH/include/StratifyIO

INSTALLS += target
INSTALLS += INSTALL_HEADERS

INCLUDEPATH += $$INSTALLPATH/include

