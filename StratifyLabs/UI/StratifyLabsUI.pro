TEMPLATE = lib
TARGET = StratifyLabsUI
QT += qml quick
CONFIG += qt plugin c++11

TARGET = $$qtLibraryTarget($$TARGET)
uri = StratifyLabs.UI
QMAKE_MOC_OPTIONS += -Muri=StratifyLabs.UI

# Input
DISTFILES = qmldir \
    STestListText.js \
    StratifyLabsUI.qmltypes \
    UI.2/SAlert.qml \
    UI.2/SAnimationContainer.qml \
    UI.2/SAnimationFade.qml \
    UI.2/SAnimationHPush.qml \
    UI.2/SBadge.qml \
    UI.2/SBreadcrumb.qml \
    UI.2/SButton.qml \
    UI.2/SCarousel.qml \
    UI.2/SCheckbox.qml \
    UI.2/SColumn.qml \
    UI.2/SContainer.qml \
    UI.2/SDrawer.qml \
    UI.2/SDropdown.qml \
    UI.2/SDropup.qml \
    UI.2/SGroup.qml \
    UI.2/SHLine.qml \
    UI.2/SIcon.qml \
    UI.2/SImage.qml \
    UI.2/SInput.qml \
    UI.2/SLabel.qml \
    UI.2/SList.qml \
    UI.2/SListgroup.qml \
    UI.2/SLoader.qml \
    UI.2/SModal.qml \
    UI.2/SNavbar.qml \
    UI.2/SPane.qml \
    UI.2/SPanel.qml \
    UI.2/SPassword.qml \
    UI.2/SPopover.qml \
    UI.2/SProgressbar.qml \
    UI.2/SProgresscircle.qml \
    UI.2/SProperties.qml \
    UI.2/SRadioButton.qml \
    UI.2/SRadioButtonControl.qml \
    UI.2/SRow.qml \
    UI.2/SScreen.qml \
    UI.2/STable.qml \
    UI.2/STableColumn.qml \
    UI.2/STest.qml \
    UI.2/SText.qml \
    UI.2/STextBox.qml \
    UI.2/STooltip.qml \
    UI.2/StratifyUI.qml \
    UI.2/STree.qml \
    UI.2/STreeColumn.qml \
    UI.2/SWell.qml \
    UI.1/SAlert.qml \
    UI.1/SAnimationContainer.qml \
    UI.1/SAnimationFade.qml \
    UI.1/SAnimationHPush.qml \
    UI.1/SBadge.qml \
    UI.1/SBaseRectangle.qml \
    UI.1/SBaseRectangleText.qml \
    UI.1/SBreadcrumb.qml \
    UI.1/SButton.qml \
    UI.1/SCarousel.qml \
    UI.1/SCheckbox.qml \
    UI.1/SColumn.qml \
    UI.1/SContainer.qml \
    UI.1/SCustomize.qml \
    UI.1/SDropdown.qml \
    UI.1/SDropdownMenu.qml \
    UI.1/SGroup.qml \
    UI.1/SHLine.qml \
    UI.1/SIcon.qml \
    UI.1/SImage.qml \
    UI.1/SInput.qml \
    UI.1/SItem.qml \
    UI.1/SJsonListModel.qml \
    UI.1/SLabel.qml \
    UI.1/SList.qml \
    UI.1/SListgroup.qml \
    UI.1/SLoader.qml \
    UI.1/SModal.qml \
    UI.1/SModalFooter.qml \
    UI.1/SModalHeader.qml \
    UI.1/SNavbar.qml \
    UI.1/SPane.qml \
    UI.1/SPanel.qml \
    UI.1/SPassword.qml \
    UI.1/SPopover.qml \
    UI.1/SProgressbar.qml \
    UI.1/SProgresscircle.qml \
    UI.1/SRadioButton.qml \
    UI.1/SRadioButtonControl.qml \
    UI.1/SRoundedRectangle.qml \
    UI.1/SRow.qml \
    UI.1/SRowSpacer.qml \
    UI.1/SScreen.qml \
    UI.1/STable.qml \
    UI.1/STableColumn.qml \
    UI.1/STest.qml \
    UI.1/SText.qml \
    UI.1/STextBox.qml \
    UI.1/STextWrap.qml \
    UI.1/STooltip.qml \
    UI.1/STree.qml \
    UI.1/STreeColumn.qml \
    UI.1/SWell.qml \
    assets/Fa-4.5.0.js \
    assets/Fa-4.7.0.js \
    assets/jsonpath-0.8.5.js \
    assets/fontawesome-4.5.0-webfont.ttf \
    assets/fontawesome-4.7.0-webfont.ttf \
    assets/OpenSans-Bold.ttf \
    assets/OpenSans-ExtraBold.ttf \
    assets/OpenSans-Light.ttf \
    assets/OpenSans-Regular.ttf \
    assets/OpenSans-Semibold.ttf \
    assets/RobotoMono-Regular.ttf

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = $$DISTFILES

installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
qmldir.path = $$installPath
target.path = $$installPath
INSTALLS += target qmldir

