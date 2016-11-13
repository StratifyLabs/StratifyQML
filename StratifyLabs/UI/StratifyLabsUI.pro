TEMPLATE = lib
TARGET = StratifyLabsUI
QT += qml quick
CONFIG += qt plugin c++11

TARGET = $$qtLibraryTarget($$TARGET)
uri = StratifyLabs.UI
QMAKE_MOC_OPTIONS += -Muri=StratifyLabs.UI

# Input
DISTFILES = qmldir \
    Fa-4.5.0.js \
    jsonpath-0.8.5.js \
    STestListText.js \
    StratifyLabsUI.qmltypes \
    SAlert.qml \
    SAnimationContainer.qml \
    SAnimationFade.qml \
    SAnimationHPush.qml \
    SBadge.qml \
    SBaseRectangle.qml \
    SBaseRectangleText.qml \
    SBreadcrumb.qml \
    SButton.qml \
    SCarousel.qml \
    SCheckbox.qml \
    SColumn.qml \
    SContainer.qml \
    SCustomize.qml \
    SDropdown.qml \
    SDropdownMenu.qml \
    SGroup.qml \
    SHLine.qml \
    SIcon.qml \
    SImage.qml \
    SInput.qml \
    SItem.qml \
    SJsonListModel.qml \
    SLabel.qml \
    SLayout.qml \
    SList.qml \
    SListgroup.qml \
    SLoader.qml \
    SModal.qml \
    SModalFooter.qml \
    SModalHeader.qml \
    SNavbar.qml \
    SPane.qml \
    SPanel.qml \
    SPassword.qml \
    SPopover.qml \
    SProgressbar.qml \
    SProgresscircle.qml \
    SRadioButton.qml \
    SRadioButtonControl.qml \
    SRoundedRectangle.qml \
    SRow.qml \
    SRowSpacer.qml \
    SScreen.qml \
    STable.qml \
    STableColumn.qml \
    STest.qml \
    SText.qml \
    STextBox.qml \
    STextWrap.qml \
    STooltip.qml \
    STree.qml \
    STreeColumn.qml \
	SWell.qml \
	fontawesome-webfont.ttf \
	OpenSans-Bold.ttf \
	OpenSans-ExtraBold.ttf \
	OpenSans-Light.ttf \
	OpenSans-Regular.ttf \
	OpenSans-Semibold.ttf

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = $$DISTFILES
unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    qmldir.path = $$installPath
    target.path = $$installPath
	INSTALLS += target qmldir
}
