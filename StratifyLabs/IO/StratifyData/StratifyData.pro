#-------------------------------------------------
#
# Project created by QtCreator 2016-10-07T11:12:08
#
#-------------------------------------------------

QT       += core network serialport
QT       -= gui

TARGET = StratifyData
TEMPLATE = lib
CONFIG += staticlib

DEFINES += __link

SOURCES += \
    Data.cpp \
    AppData.cpp \
    HardwareData.cpp \
    UserData.cpp \
    DeviceData.cpp \
    StratifyObject.cpp \
    FirebaseDataService.cpp \
    DataService.cpp \
	StratifyPrompt.cpp

HEADERS += Data.h \
    Worker.h \
    AppData.h \
	HardwareData.h \
	DataService.h \
	DeviceData.h \
    UserData.h \
	FirebaseDataService.h \
	StratifyData.h \
    StratifyObject.h \
	StratifyPrompt.h

INSTALL_HEADERS.files = $$HEADERS

macx:INSTALLPATH = /Applications/StratifyLabs-SDK/Tools/gcc
win32:INSTALLPATH = c:/StratifyLabs-SDK/Tools/gcc

target.path = $$INSTALLPATH/lib
INSTALL_HEADERS.path = $$INSTALLPATH/include/StratifyIO
INSTALL_FIREBASE_HEADERS.path = $$INSTALLPATH/include/StratifyIO/FirebaseApi



include(./FirebaseApi/firebaseapi.pri)

INSTALL_FIREBASE_HEADERS.files = $$FIREBASE_HEADERS
HEADER += $$FIREBASE_HEADERS


DESTDIR = $$PWD/../../../StratifyExample/StratifyLib

INSTALLS += target
INSTALLS += INSTALL_HEADERS
INSTALLS += INSTALL_FIREBASE_HEADERS
