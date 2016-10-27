#-------------------------------------------------
#
# Project created by QtCreator 2016-10-07T11:12:08
#
#-------------------------------------------------

QT       += core network
QT       -= gui

TARGET = StratifyData
TEMPLATE = lib
CONFIG += staticlib

SOURCES += \
    Data.cpp \
    AppData.cpp \
    HardwareData.cpp \
    UserData.cpp \
    DeviceData.cpp \
    FirebaseDataService.cpp \
    DataService.cpp \
	StratifyObject.cpp \
	StratifyPrompt.cpp \
    AppListData.cpp \
    ListData.cpp

HEADERS += Data.h \
    Worker.h \
    AppData.h \
	HardwareData.h \
    UserData.h \
	DeviceData.h \
	FirebaseDataService.h \
	DataService.h \
	StratifyData.h \
    StratifyObject.h \
	StratifyPrompt.h \
    AppListData.h \
    ListData.h

INSTALL_HEADERS.files = $$HEADERS

macx:INSTALLPATH = /Applications/StratifyLabs-SDK/Tools/gcc
win32:INSTALLPATH = c:/StratifyLabs-SDK/Tools/gcc

target.path = $$INSTALLPATH/lib
INSTALL_HEADERS.path = $$INSTALLPATH/include/StratifyData
INSTALL_FIREBASE_HEADERS.path = $$INSTALLPATH/include/StratifyData/FirebaseApi

include(./FirebaseApi/firebaseapi.pri)

INSTALL_FIREBASE_HEADERS.files = $$FIREBASE_HEADERS
HEADERS += $$FIREBASE_HEADERS

INSTALLS += target
INSTALLS += INSTALL_HEADERS
INSTALLS += INSTALL_FIREBASE_HEADERS


