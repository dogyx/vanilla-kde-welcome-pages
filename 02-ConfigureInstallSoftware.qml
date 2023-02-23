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

    property int _num: 0

    property bool _timeshift: false
    property bool _codecs: false

    property bool _flatpak: true
    property bool _appimage: true

    property bool _core_apps: true
    property bool _office: false
    property bool _utilities: false

    property var apps_core_list: ["Filelight", "Kontact", "Kamoso", "Okular", "Gwenview", "KCharSelect", "Weather", "Kate"]
    property var apps_util_list: ["Heroic Games Launcher", "Vorta", "Elisa", "Audacity"]

    onIsCurrentPageChanged: if (pageStack.currentIndex === 8) {
                                _num += 1
                                if (_num === 2)
                                {   // This is a placeholder. TODO: Replace with a bash script that actually installs the packages
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
            readonly property int cellHeight: Math.max(pacman_btn.implicitHeight,
                                                       apps_btn.implicitHeight,
                                                       codecs_btn.implicitHeight,
                                                       timeshift_btn.implicitHeight)

            columnSpacing: Kirigami.Units.smallSpacing
            rowSpacing: Kirigami.Units.smallSpacing

            Layout.fillWidth: true

            QQC2.Button {
                id: pacman_btn

                Layout.preferredWidth: grid.cellWidth
                Layout.preferredHeight: grid.cellHeight

                padding: Kirigami.Units.largeSpacing

                onClicked: {
                    pageStack.layers.push(package_managers)
                    prevButton.enabled = false
                }
                contentItem: ColumnLayout {
                    spacing: 0

                    RowLayout {
                        spacing: Kirigami.Units.smallSpacing
                        Layout.minimumHeight: Kirigami.Units.gridUnit * 2 + spacing

                        // Icon
                        Kirigami.Icon {
                            Layout.preferredWidth: Kirigami.Units.iconSizes.medium
                            Layout.preferredHeight: Kirigami.Units.iconSizes.medium
                            Layout.alignment: Qt.AlignVCenter
                            source: "package-x-generic"
                        }
                        // Title
                        Kirigami.Heading {
                            Layout.fillWidth: true
                            level: 4
                            text: i18n("Package Managers")
                            verticalAlignment: Text.AlignVCenter
                            maximumLineCount: 2
                            elide: Text.ElideRight
                            wrapMode: Text.Wrap
                        }
                    }

                    // Subtitle
                    QQC2.Label {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: i18n("Choose package manager(s) for your system")
                        elide: Text.ElideRight
                        wrapMode: Text.Wrap
                        opacity: 0.6
                        verticalAlignment: Text.AlignTop
                    }
                }
            }

            QQC2.Button {
                id: apps_btn

                Layout.preferredWidth: grid.cellWidth
                Layout.preferredHeight: grid.cellHeight

                padding: Kirigami.Units.largeSpacing

                onClicked: {
                    pageStack.layers.push(applications)
                    prevButton.enabled = false
                }

                contentItem: ColumnLayout {
                    spacing: 0

                    RowLayout {
                        spacing: Kirigami.Units.smallSpacing
                        Layout.minimumHeight: Kirigami.Units.gridUnit * 2 + spacing

                        // Icon
                        Kirigami.Icon {
                            Layout.preferredWidth: Kirigami.Units.iconSizes.medium
                            Layout.preferredHeight: Kirigami.Units.iconSizes.medium
                            Layout.alignment: Qt.AlignVCenter
                            source: "applications-all"
                        }
                        // Title
                        Kirigami.Heading {
                            Layout.fillWidth: true
                            level: 4
                            text: i18n("Applications")
                            verticalAlignment: Text.AlignVCenter
                            maximumLineCount: 2
                            elide: Text.ElideRight
                            wrapMode: Text.Wrap
                        }
                    }

                    // Subtitle
                    QQC2.Label {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: i18n("Choose applications to install")
                        elide: Text.ElideRight
                        wrapMode: Text.Wrap
                        opacity: 0.6
                        verticalAlignment: Text.AlignTop
                    }
                }
            }

            QQC2.Button {
                id: codecs_btn

                Layout.preferredWidth: grid.cellWidth
                Layout.preferredHeight: grid.cellHeight

                padding: Kirigami.Units.largeSpacing

                onClicked: {
                    pageStack.layers.push(codecs)
                    prevButton.enabled = false
                }

                contentItem: ColumnLayout {
                    spacing: 0

                    RowLayout {
                        spacing: Kirigami.Units.smallSpacing
                        Layout.minimumHeight: Kirigami.Units.gridUnit * 2 + spacing

                        // Icon
                        Kirigami.Icon {
                            Layout.preferredWidth: Kirigami.Units.iconSizes.medium
                            Layout.preferredHeight: Kirigami.Units.iconSizes.medium
                            Layout.alignment: Qt.AlignVCenter
                            source: "package"
                        }
                        // Title
                        Kirigami.Heading {
                            Layout.fillWidth: true
                            level: 4
                            text: i18n("Restricted Codecs")
                            verticalAlignment: Text.AlignVCenter
                            maximumLineCount: 2
                            elide: Text.ElideRight
                            wrapMode: Text.Wrap
                        }
                    }

                    // Subtitle
                    QQC2.Label {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: i18n("Choose whether to install codecs and fonts")
                        elide: Text.ElideRight
                        wrapMode: Text.Wrap
                        opacity: 0.6
                        verticalAlignment: Text.AlignTop
                    }
                }
            }

            QQC2.Button {
                id: timeshift_btn

                Layout.preferredWidth: grid.cellWidth
                Layout.preferredHeight: grid.cellHeight

                padding: Kirigami.Units.largeSpacing

                onClicked: {
                    pageStack.layers.push(timeshift)
                    prevButton.enabled = false
                }

                contentItem: ColumnLayout {
                    spacing: 0

                    RowLayout {
                        spacing: Kirigami.Units.smallSpacing
                        Layout.minimumHeight: Kirigami.Units.gridUnit * 2 + spacing

                        // Icon
                        Kirigami.Icon {
                            Layout.preferredWidth: Kirigami.Units.iconSizes.medium
                            Layout.preferredHeight: Kirigami.Units.iconSizes.medium
                            Layout.alignment: Qt.AlignVCenter
                            source: "backup"
                        }
                        // Title
                        Kirigami.Heading {
                            Layout.fillWidth: true
                            level: 4
                            text: i18n("Timeshift")
                            verticalAlignment: Text.AlignVCenter
                            maximumLineCount: 2
                            elide: Text.ElideRight
                            wrapMode: Text.Wrap
                        }
                    }

                    // Subtitle
                    QQC2.Label {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: i18n("Choose whether to install Timeshift to create snapshots of your system")
                        elide: Text.ElideRight
                        wrapMode: Text.Wrap
                        opacity: 0.6
                        verticalAlignment: Text.AlignTop
                    }
                }
            }


        }
    }

    Component {
        id: package_managers

        GenericPage {
            globalToolBarStyle: Kirigami.ApplicationHeaderStyle.None

            heading: i18nc("@info:window", "Package Managers")
            description: xi18nc("@info:usagetip", "Choose one or more package managers to install")

            GridLayout {
                columns: 1
                rowSpacing: Kirigami.Units.smallSpacing

                Layout.fillWidth: true

                QQC2.Container {

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    padding: Kirigami.Units.largeSpacing

                    contentItem: RowLayout {
                        spacing: Kirigami.Units.smallSpacing

                        QQC2.CheckBox {
                            checked: _flatpak
                            onClicked: _flatpak = !_flatpak
                        }

                        ColumnLayout {
                            spacing: 0

                            Kirigami.Heading {
                                Layout.fillWidth: true
                                level: 4
                                text: i18n("Flatpak")
                                verticalAlignment: Text.AlignVCenter
                                maximumLineCount: 2
                                elide: Text.ElideRight
                                wrapMode: Text.Wrap
                            }

                            QQC2.Label {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                text: i18n("Manage and configure flatpak and flathub repository")
                                elide: Text.ElideRight
                                wrapMode: Text.Wrap
                                opacity: 0.6
                                verticalAlignment: Text.AlignTop
                            }
                        }
                    }
                }

                QQC2.Container {

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    padding: Kirigami.Units.largeSpacing

                    contentItem: RowLayout {
                        spacing: Kirigami.Units.smallSpacing

                        QQC2.CheckBox {
                            checked: _appimage
                            onClicked: _appimage = !_appimage
                        }

                        ColumnLayout {
                            spacing: 0

                            Kirigami.Heading {
                                Layout.fillWidth: true
                                level: 4
                                text: i18n("AppImage")
                                verticalAlignment: Text.AlignVCenter
                                maximumLineCount: 2
                                elide: Text.ElideRight
                                wrapMode: Text.Wrap
                            }

                            QQC2.Label {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                text: i18n("Install necessary dependencies to run AppImages")
                                elide: Text.ElideRight
                                wrapMode: Text.Wrap
                                opacity: 0.6
                                verticalAlignment: Text.AlignTop
                            }
                        }
                    }
                }
            }

            QQC2.Button {
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
        }
    }

     Component {
        id: applications

        GenericPage {
            globalToolBarStyle: Kirigami.ApplicationHeaderStyle.None

            heading: i18nc("@info:window", "Applications")
            description: xi18nc("@info:usagetip", "Choose which applications to install")

            GridLayout {
                columns: 1
                rowSpacing: Kirigami.Units.smallSpacing

                Layout.fillWidth: true

                QQC2.Container {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    padding: Kirigami.Units.largeSpacing

                    contentItem: RowLayout {
                        spacing: Kirigami.Units.smallSpacing

                        QQC2.CheckBox {
                            checked: _core_apps
                            onClicked: _core_apps = !_core_apps
                        }

                        ColumnLayout {
                            spacing: 0

                            Kirigami.Heading {
                                Layout.fillWidth: true
                                level: 4
                                text: i18n("Core Applications")
                                verticalAlignment: Text.AlignVCenter
                                maximumLineCount: 2
                                elide: Text.ElideRight
                                wrapMode: Text.Wrap
                            }

                            QQC2.Label {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                text: i18n("Essential applications like a text editor and a document viewer")
                                elide: Text.ElideRight
                                wrapMode: Text.Wrap
                                opacity: 0.6
                                verticalAlignment: Text.AlignTop
                            }
                        }
                        QQC2.Button {
                            text: i18n("Edit")
                            onClicked: core_apps_overlay.open()
                        }
                    }
                }

                QQC2.Container {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    padding: Kirigami.Units.largeSpacing

                    contentItem: RowLayout {
                        spacing: Kirigami.Units.smallSpacing

                        QQC2.CheckBox {
                            checked: _office
                            onClicked: _office = !_office
                        }

                        ColumnLayout {
                            spacing: 0

                            Kirigami.Heading {
                                Layout.fillWidth: true
                                level: 4
                                text: i18n("Office")
                                verticalAlignment: Text.AlignVCenter
                                maximumLineCount: 2
                                elide: Text.ElideRight
                                wrapMode: Text.Wrap
                            }

                            QQC2.Label {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                text: i18n("The LibreOffice Suite")
                                elide: Text.ElideRight
                                wrapMode: Text.Wrap
                                opacity: 0.6
                                verticalAlignment: Text.AlignTop
                            }
                        }
                    }
                }

                QQC2.Container {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    padding: Kirigami.Units.largeSpacing

                    contentItem: RowLayout {
                        spacing: Kirigami.Units.smallSpacing

                        QQC2.CheckBox {
                            checked: _utilities
                            onClicked: _utilities = !_utilities
                        }

                        ColumnLayout {
                            spacing: Kirigami.Units.smallSpacing

                            Kirigami.Heading {
                                Layout.fillWidth: true
                                level: 4
                                text: i18n("Common Utilities")
                                verticalAlignment: Text.AlignVCenter
                                maximumLineCount: 2
                                elide: Text.ElideRight
                                wrapMode: Text.Wrap
                            }

                            QQC2.Label {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                text: i18n("Useful utilities like Bottles or Sound Recorder")
                                elide: Text.ElideRight
                                wrapMode: Text.Wrap
                                opacity: 0.6
                                verticalAlignment: Text.AlignTop
                            }
                        }
                        QQC2.Button {
                            text: i18n("Edit")
                            onClicked: utilities_overlay.open()
                            enabled: _utilities
                        }
                    }
                }
            }

            QQC2.Button {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: Kirigami.Units.gridUnit * 3
                anchors.horizontalCenter: parent.horizontalCenter

                icon.name: "go-previous-view"
                text: i18nc("@action:button", "Go Back")
                onClicked: go_back()
            }
        }
    }

    Component {
        id: codecs

        GenericPage {
            globalToolBarStyle: Kirigami.ApplicationHeaderStyle.None

            heading: i18nc("@info:window", "Install Restricted Codecs")
            description: xi18nc("@info:usagetip", "Install drivers, fonts and other essentials from the ubuntu-restricted-extras and ubuntu-restricted-addons repositories.")

            RowLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0
                QQC2.CheckBox {
                    checked: _codecs
                    onClicked: _codecs = !_codecs
                }
                QQC2.Label {
                    text: "Enable Restricted Codecs"
                }
            }

            QQC2.Button {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: Kirigami.Units.gridUnit * 3
                anchors.horizontalCenter: parent.horizontalCenter

                icon.name: "go-previous-view"
                text: i18nc("@action:button", "Go Back")
                onClicked: go_back()
            }
        }
    }

    Component {
        id: timeshift

        GenericPage {
            globalToolBarStyle: Kirigami.ApplicationHeaderStyle.None

            heading: i18nc("@info:window", "Install Timeshift for system snapshots")
            description: xi18nc("@info:usagetip", "Timeshift for Linux is an application that provides functionality similar to the System Restore feature in Windows and the Time Machine tool in Mac OS. Timeshift protects your system by taking incremental snapshots of the file system at regular intervals. These snapshots can be restored at a later date to undo all changes to the system.")

                RowLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 0
                    QQC2.CheckBox {
                        checked: _timeshift
                        onClicked: _timeshift = !_timeshift
                    }
                    QQC2.Label {
                        text: "Enable Timeshift"
                    }
                }

            QQC2.Button {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: Kirigami.Units.gridUnit * 3
                anchors.horizontalCenter: parent.horizontalCenter

                icon.name: "go-previous-view"
                text: i18nc("@action:button", "Go Back")
                onClicked: go_back()
            }
        }
    }

    function go_back() {
        pageStack.layers.pop();
        prevButton.enabled = true
    }

    //
    // Overlays
    //

    Kirigami.OverlaySheet {
        id: core_apps_overlay
        header: Kirigami.Heading {
            text: i18nc("@title:window", "Select Applications")
        }
        ListView {
            model: apps_core_list.length
            delegate: Kirigami.CheckableListItem {
                checked: true
                label: i18n(apps_core_list[index])
            }
        }
    }
    Kirigami.OverlaySheet {
        id: utilities_overlay
        header: Kirigami.Heading {
            text: i18nc("@title:window", "Select Applications")
        }
        ListView {
            model: apps_util_list.length
            delegate: Kirigami.CheckableListItem {
                checked: true
                label: i18n(apps_util_list[index])
            }
        }
    }
}


