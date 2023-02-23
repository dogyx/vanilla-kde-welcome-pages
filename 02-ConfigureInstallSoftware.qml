/*
 *  SPDX-FileCopyrightText: 2021 Felipe Kinoshita <kinofhek@gmail.com>
 *  SPDX-FileCopyrightText: 2022 Nate Graham <nate@kde.org>
 *
 *  SPDX-FileCopyrightText: 2023 dogyx
 *
 *  SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only OR LicenseRef-KDE-Accepted-GPL
 */

import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.15 as Kirigami

import org.kde.welcome 1.0
import org.kde.plasma.welcome 1.0


GenericPage {
    heading: i18nc("@info:window", "Configure Package Managers & Install Software")
    description: xi18nc("@info:usagetip", "Choose package managers to use for your system and which applications to install. <nl/>Leave everything as is and continue for default values.")

    property var apps_core_list: ["Filelight", "Kontact", "Kamoso", "Okular", "Gwenview", "KCharSelect", "Weather", "Kate"]
    property var apps_util_list: ["Heroic Games Launcher", "Vorta", "Elisa", "Audacity"]


    // HACK: detect when user clicks 'next' on page 8
    property int _page_8_flicked_count: 0
    onIsCurrentPageChanged: if (pageStack.currentIndex === 8) {
                                // This incrementation and the following if-branch are
                                // needed because 'pageStack.currentIndex === 8' evaluates
                                // to true once right when starting plasma-welcome
                                _page_8_flicked_count += 1
                                if (_page_8_flicked_count === 2) {   // This is a placeholder. TODO: Replace with a bash script that actually installs the packages
                                    Controller.runCommand("notify-send \"System\" \"Installing packages...\"", "Send-Notification")
                                }
                            }

    ColumnLayout {
        id: layout

        anchors {
            top: parent.top
            topMargin: Kirigami.Units.largeSpacing
            left: parent.left
            right: parent.right
        }
        spacing: Kirigami.Units.largeSpacing * 6

        GridLayout {
            id: grid
            columns: 2

            readonly property int cellWidth: Math.round((layout.width - columnSpacing * (columns - 1)) / columns)
            readonly property int cellHeight: Math.max(pm_btn.implicitHeight, app_btn.implicitHeight, rc_btn.implicitHeight, ts_btn.implicitHeight)

            columnSpacing: Kirigami.Units.smallSpacing
            rowSpacing: Kirigami.Units.smallSpacing

            Layout.fillWidth: true

            CustomButton {
                id: pm_btn
                title_text: "Package Managers"
                subtitle_text: "Choose package manager(s) for your system"
                icon_source: "package-x-generic"
                page_id: package_managers
            }

            CustomButton {
                id: app_btn
                title_text: "Applications"
                subtitle_text: "Choose applications to install"
                icon_source: "applications-all"
                page_id: applications
            }

            CustomButton {
                id: rc_btn
                title_text: "Restricted Codecs"
                subtitle_text: "Choose whether to install codecs and fonts"
                icon_source: "package"
                page_id: codecs
            }

            CustomButton {
                id: ts_btn
                title_text: "Timeshift"
                subtitle_text: "Choose whether to install Timeshift to create snapshots of your system"
                icon_source: "backup"
                page_id: timeshift
            }
        }
    }

    Component {
        id: package_managers

        GenericPage {
            globalToolBarStyle: Kirigami.ApplicationHeaderStyle.None

            heading: i18nc("@info:window", "Package Managers")
            description: xi18nc("@info:usagetip", "Choose one or more package managers to install")

            ColumnLayout {
                Layout.fillWidth: true

                CustomListItem {
                    item_checked: true
                    title_text: "Flatpak"
                    subtitle_text: "Manage and configure flatpak and flathub repository"
                    button_visible: false
                }

                CustomListItem {
                    item_checked: true
                    title_text: "AppImage"
                    subtitle_text: "Install necessary dependencies to run AppImages"
                    button_visible: false
                }
            }

            BackButton {}
        }
    }

    Component {
        id: applications

        GenericPage {
            globalToolBarStyle: Kirigami.ApplicationHeaderStyle.None

            heading: i18nc("@info:window", "Applications")
            description: xi18nc("@info:usagetip", "Choose which applications to install")

            ColumnLayout {
                Layout.fillWidth: true

                CustomListItem {
                    item_checked: true
                    title_text: "Core Applications"
                    subtitle_text: "Essential applications like a text editor and a document viewer"
                    button_visible: true
                    overlay_id: core_apps_overlay
                }

                CustomListItem {
                    item_checked: false
                    title_text: "Office"
                    subtitle_text: "The LibreOffice suite"
                    button_visible: false
                }

                CustomListItem {
                    item_checked: false
                    title_text: "Common Utilities"
                    subtitle_text: "Useful utilities like Bottles or Sound Recorder"
                    overlay_id: utilities_overlay
                    button_visible: true
                }
            }

            BackButton {}
        }
    }

    PageCheckBoxLabel {
        id: timeshift
        item_checked: false
        item_label: "Enable Timeshift"
        heading_title: "Install Timeshift for system snapshots"
        page_desc: "Timeshift for Linux is an application that provides functionality similar to the System Restore feature in Windows and the Time Machine tool in Mac OS. Timeshift protects your system by taking incremental snapshots of the file system at regular intervals. These snapshots can be restored at a later date to undo all changes to the system."
    }

    PageCheckBoxLabel {
        id: codecs
        item_checked: false
        item_label: "Enable Restricted Codecs"
        heading_title: "Install Restricted Codecs"
        page_desc: "Install drivers, fonts and other essentials from the ubuntu-restricted-extras and ubuntu-restricted-addons repositories."
    }

    AppsListOverlay {
        id: core_apps_overlay
        lv_model: apps_core_list.length
        lv_item_checked: true
        lv_item_label: apps_core_list
    }

    AppsListOverlay {
        id: utilities_overlay
        lv_model: apps_util_list.length
        lv_item_checked: false
        lv_item_label: apps_util_list
    }

    component BackButton: QQC2.Button {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Kirigami.Units.gridUnit * 3
        anchors.horizontalCenter: parent.horizontalCenter

        icon.name: "go-previous-view"
        text: i18nc("@action:button", "Go Back")
        onClicked: {
            pageStack.layers.pop();
            prevButton.enabled = true
        }
    }

    component AppsListOverlay: Kirigami.OverlaySheet {
        property var lv_model
        property var lv_item_checked
        property var lv_item_label
        header: Kirigami.Heading {
            text: i18nc("@title:window", "Select Applications")
        }
        ListView {
            model: lv_model
            delegate: Kirigami.CheckableListItem {
                checked: lv_item_checked
                label: lv_item_label[index]
            }
        }
    }

    component PageCheckBoxLabel: GenericPage {

        property bool item_checked
        property string item_label
        property string heading_title
        property string page_desc

        globalToolBarStyle: Kirigami.ApplicationHeaderStyle.None

        heading: heading_title
        description: page_desc

            RowLayout {
                id: _row
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0
                QQC2.CheckBox {
                    checked: item_checked
                    onClicked: item_checked = !item_checked
                }
                QQC2.Label {
                    text: item_label
                }
            }
        BackButton { }
    }

    component CustomListItem: QQC2.Container {
        property bool item_checked
        property string title_text
        property string subtitle_text
        property var overlay_id
        property bool button_visible

        Layout.fillWidth: true
        Layout.fillHeight: true

        padding: Kirigami.Units.largeSpacing

        contentItem: RowLayout {
            spacing: Kirigami.Units.smallSpacing

            QQC2.CheckBox {
                id: _cb
                checked: item_checked
                onClicked: item_checked
            }

            ColumnLayout {
                spacing: Kirigami.Units.smallSpacing

                Kirigami.Heading {
                    Layout.fillWidth: true
                    level: 4
                    text: title_text
                    verticalAlignment: Text.AlignVCenter
                    maximumLineCount: 2
                    elide: Text.ElideRight
                    wrapMode: Text.Wrap
                }

                QQC2.Label {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    text: subtitle_text
                    elide: Text.ElideRight
                    wrapMode: Text.Wrap
                    opacity: 0.6
                    verticalAlignment: Text.AlignTop
                }
            }
            QQC2.Button {
                text: i18n("Edit")
                onClicked: overlay_id.open()
                enabled: _cb.checked
                visible: button_visible
            }
        }
    }

    component CustomButton: QQC2.Button {

        property string title_text
        property string subtitle_text
        property string icon_source
        property var page_id

        Layout.preferredWidth: grid.cellWidth
        Layout.preferredHeight: grid.cellHeight

        padding: Kirigami.Units.largeSpacing

        onClicked: {
            pageStack.layers.push(page_id)
            prevButton.enabled = false
        }

        contentItem: ColumnLayout {
            spacing: 0

            RowLayout {
                spacing: Kirigami.Units.smallSpacing
                Layout.minimumHeight: Kirigami.Units.gridUnit * 2 + spacing

                Kirigami.Icon {
                    Layout.preferredWidth: Kirigami.Units.iconSizes.medium
                    Layout.preferredHeight: Kirigami.Units.iconSizes.medium
                    Layout.alignment: Qt.AlignVCenter
                    source: icon_source
                }
                Kirigami.Heading {
                    Layout.fillWidth: true
                    level: 4
                    text: title_text
                    verticalAlignment: Text.AlignVCenter
                    maximumLineCount: 2
                    elide: Text.ElideRight
                    wrapMode: Text.Wrap
                }
            }
            QQC2.Label {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: subtitle_text
                elide: Text.ElideRight
                wrapMode: Text.Wrap
                opacity: 0.6
                verticalAlignment: Text.AlignTop
            }
        }
    }
}


