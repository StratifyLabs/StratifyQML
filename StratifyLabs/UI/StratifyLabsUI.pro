TEMPLATE = lib
TARGET = StratifyLabsUI
QT += qml quick
CONFIG += qt plugin c++11

TARGET = $$qtLibraryTarget($$TARGET)
uri = StratifyLabs.UI
QMAKE_MOC_OPTIONS += -Muri=StratifyLabs.UI

# Input

ASSETFILES = $$files(assets/*.js) $$files(assets/*.ttf)

DISTFILES1 = $$files(UI.1/*.qml)
DISTFILES2 = $$files(UI.2/*.qml)

DISTFILES = qmldir \
    STestListText.js \
	StratifyLabsUI.qmltypes

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = $$DISTFILES

ui1.files = $$DISTFILES1
ui2.files = $$DISTFILES2
assets.files = $$ASSETFILES

installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
target.path = $$installPath
qmldir.path = $$installPath
ui1.path = $$installPath/UI.1
ui2.path = $$installPath/UI.2
assets.path = $$installPath/assets

INSTALLS += target qmldir ui1 ui2 assets

