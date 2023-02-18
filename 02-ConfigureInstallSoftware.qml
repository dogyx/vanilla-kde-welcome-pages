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
//import QtGraphicalEffects 1.15

import org.kde.plasma.welcome 1.0
import org.kde.welcome 1.0


GenericPage {
    heading: i18nc("@info:window", "Configure Package Managers & Install Software")
    description: xi18nc("@info:usagetip", "Choose package managers to use for your system and which applications to install. <nl/>Leave everything as is and continue for default values.")

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
            readonly property int cellHeight: Math.max(pacman_btn.implicitHeight, apps_btn.implicitHeight)

            columnSpacing: Kirigami.Units.smallSpacing
            rowSpacing: Kirigami.Units.smallSpacing

            Layout.fillWidth: true

            QQC2.Button {
                id: pacman_btn

                implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                        implicitContentWidth + leftPadding + rightPadding)
                implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                                        implicitContentHeight + topPadding + bottomPadding)

                Layout.preferredWidth: grid.cellWidth
                Layout.preferredHeight: grid.cellHeight

                leftPadding: Kirigami.Units.largeSpacing
                rightPadding: Kirigami.Units.largeSpacing
                topPadding: Kirigami.Units.largeSpacing
                bottomPadding: Kirigami.Units.largeSpacing

                onClicked: pageStack.layers.push(package_managers)

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
                            text: "Package Managers"
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
                        visible: true
                        text: "Choose package manager(s) for your system"
                        elide: Text.ElideRight
                        wrapMode: Text.Wrap
                        opacity: 0.6
                        verticalAlignment: Text.AlignTop
                    }
                }
            }

            QQC2.Button {
                id: apps_btn

                implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                        implicitContentWidth + leftPadding + rightPadding)
                implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                                        implicitContentHeight + topPadding + bottomPadding)

                Layout.preferredWidth: grid.cellWidth
                Layout.preferredHeight: grid.cellHeight

                leftPadding: Kirigami.Units.largeSpacing
                rightPadding: Kirigami.Units.largeSpacing
                topPadding: Kirigami.Units.largeSpacing
                bottomPadding: Kirigami.Units.largeSpacing

                onClicked: pageStack.layers.push(applications)

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
                            text: "Applications"
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
                        visible: true
                        text: "Choose applications to install"
                        elide: Text.ElideRight
                        wrapMode: Text.Wrap
                        opacity: 0.6
                        verticalAlignment: Text.AlignTop
                    }
                }
            }

            QQC2.Button {
                id: codecs_btn

                implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                        implicitContentWidth + leftPadding + rightPadding)
                implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                                        implicitContentHeight + topPadding + bottomPadding)

                Layout.preferredWidth: grid.cellWidth
                Layout.preferredHeight: grid.cellHeight

                leftPadding: Kirigami.Units.largeSpacing
                rightPadding: Kirigami.Units.largeSpacing
                topPadding: Kirigami.Units.largeSpacing
                bottomPadding: Kirigami.Units.largeSpacing

                onClicked: pageStack.layers.push(codecs)

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
                            text: "Restricted Codecs"
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
                        visible: true
                        text: "Choose whether to install codecs and fonts"
                        elide: Text.ElideRight
                        wrapMode: Text.Wrap
                        opacity: 0.6
                        verticalAlignment: Text.AlignTop
                    }
                }
            }

            QQC2.Button {
                id: timeshift_btn

                implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                        implicitContentWidth + leftPadding + rightPadding)
                implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                                        implicitContentHeight + topPadding + bottomPadding)

                Layout.preferredWidth: grid.cellWidth
                Layout.preferredHeight: grid.cellHeight

                leftPadding: Kirigami.Units.largeSpacing
                rightPadding: Kirigami.Units.largeSpacing
                topPadding: Kirigami.Units.largeSpacing
                bottomPadding: Kirigami.Units.largeSpacing

                onClicked: pageStack.layers.push(timeshift)

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
                            text: "Timeshift"
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
                        visible: true
                        text: "Choose whether to install Timeshift to create snapshots of your system"
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

                QQC2.Frame {
                    id: core_apps

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    padding: Kirigami.Units.largeSpacing

                    contentItem: RowLayout {
                        spacing: 0
                        RowLayout {
                            spacing: Kirigami.Units.largeSpacing
                            ColumnLayout {
                                spacing: Kirigami.Units.smallSpacing
                                Layout.minimumHeight: Kirigami.Units.gridUnit * 2 + spacing

                                // Title
                                Kirigami.Heading {
                                    Layout.fillWidth: true
                                    level: 4
                                    text: "Flatpak"
                                    verticalAlignment: Text.AlignVCenter
                                    maximumLineCount: 2
                                    elide: Text.ElideRight
                                    wrapMode: Text.Wrap
                                }

                                QQC2.Label {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    visible: true
                                    text: "Manage and configure flatpak and flathub repository"
                                    elide: Text.ElideRight
                                    wrapMode: Text.Wrap
                                    opacity: 0.6
                                    verticalAlignment: Text.AlignTop
                                }
                            }

                            QQC2.CheckBox {

                            }

                        }

                    }
                }

                QQC2.Frame {
                    id: office_apps

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    padding: Kirigami.Units.largeSpacing

                    contentItem: RowLayout {
                        spacing: 0
                        RowLayout {
                            spacing: Kirigami.Units.largeSpacing
                            ColumnLayout {
                                spacing: Kirigami.Units.smallSpacing
                                Layout.minimumHeight: Kirigami.Units.gridUnit * 2 + spacing

                                // Title
                                Kirigami.Heading {
                                    Layout.fillWidth: true
                                    level: 4
                                    text: "AppImage"
                                    verticalAlignment: Text.AlignVCenter
                                    maximumLineCount: 2
                                    elide: Text.ElideRight
                                    wrapMode: Text.Wrap
                                }

                                QQC2.Label {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    text: "Install necessary dependencies to run AppImages"
                                    elide: Text.ElideRight
                                    wrapMode: Text.Wrap
                                    opacity: 0.6
                                    verticalAlignment: Text.AlignTop
                                }
                            }

                            QQC2.CheckBox {

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
                onClicked: pageStack.layers.pop();
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

                QQC2.Frame {
                    id: core_apps

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    padding: Kirigami.Units.largeSpacing

                    contentItem: RowLayout {
                        spacing: 0
                        RowLayout {
                            spacing: Kirigami.Units.largeSpacing
                            ColumnLayout {
                                spacing: Kirigami.Units.smallSpacing
                                Layout.minimumHeight: Kirigami.Units.gridUnit * 2 + spacing

                                // Title
                                Kirigami.Heading {
                                    Layout.fillWidth: true
                                    level: 4
                                    text: "Core Applications"
                                    verticalAlignment: Text.AlignVCenter
                                    maximumLineCount: 2
                                    elide: Text.ElideRight
                                    wrapMode: Text.Wrap
                                }

                                QQC2.Label {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    visible: true
                                    text: "Essential KDE applications like a text editor and a document viewer"
                                    elide: Text.ElideRight
                                    wrapMode: Text.Wrap
                                    opacity: 0.6
                                    verticalAlignment: Text.AlignTop
                                }
                            }

                            QQC2.CheckBox {

                            }

                        }

                    }
                }

                QQC2.Frame {
                    id: office_apps

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    padding: Kirigami.Units.largeSpacing

                    contentItem: RowLayout {
                        spacing: 0
                        RowLayout {
                            spacing: Kirigami.Units.largeSpacing
                            ColumnLayout {
                                spacing: Kirigami.Units.smallSpacing
                                Layout.minimumHeight: Kirigami.Units.gridUnit * 2 + spacing

                                // Title
                                Kirigami.Heading {
                                    Layout.fillWidth: true
                                    level: 4
                                    text: "Office"
                                    verticalAlignment: Text.AlignVCenter
                                    maximumLineCount: 2
                                    elide: Text.ElideRight
                                    wrapMode: Text.Wrap
                                }

                                QQC2.Label {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    text: "The LibreOffice Suite"
                                    elide: Text.ElideRight
                                    wrapMode: Text.Wrap
                                    opacity: 0.6
                                    verticalAlignment: Text.AlignTop
                                }
                            }

                            QQC2.CheckBox {

                            }

                        }

                    }
                }

                QQC2.Frame {
                    id: utilites_apps

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    padding: Kirigami.Units.largeSpacing

                    contentItem: RowLayout {
                        spacing: 0
                        RowLayout {
                            spacing: Kirigami.Units.largeSpacing
                            ColumnLayout {
                                spacing: Kirigami.Units.smallSpacing
                                Layout.minimumHeight: Kirigami.Units.gridUnit * 2 + spacing

                                // Title
                                Kirigami.Heading {
                                    Layout.fillWidth: true
                                    level: 4
                                    text: "Common Utilities"
                                    verticalAlignment: Text.AlignVCenter
                                    maximumLineCount: 2
                                    elide: Text.ElideRight
                                    wrapMode: Text.Wrap
                                }

                                QQC2.Label {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    text: "Useful utilities like Bottles or Sound Recorder"
                                    elide: Text.ElideRight
                                    wrapMode: Text.Wrap
                                    opacity: 0.6
                                    verticalAlignment: Text.AlignTop
                                }
                            }

                            QQC2.CheckBox {

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
                onClicked: pageStack.layers.pop();
            }
        }
    }

    Component {
        id: codecs

        GenericPage {
            globalToolBarStyle: Kirigami.ApplicationHeaderStyle.None

            heading: i18nc("@info:window", "Install Restricted Codecs")
            description: xi18nc("@info:usagetip", "Choose whether to install codecs and fonts")

            QQC2.Button {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: Kirigami.Units.gridUnit * 3
                anchors.horizontalCenter: parent.horizontalCenter

                icon.name: "go-previous-view"
                text: i18nc("@action:button", "Go Back")
                onClicked: pageStack.layers.pop();
            }
        }
    }

    Component {
        id: timeshift

        GenericPage {
            globalToolBarStyle: Kirigami.ApplicationHeaderStyle.None

            heading: i18nc("@info:window", "Install Timeshift for system snapshots")
            description: xi18nc("@info:usagetip", "Timeshift for Linux is an application that provides functionality similar to the System Restore feature in Windows and the Time Machine tool in MacOS. TimeShift protects your system by taking incremental snapshots of the file system at regualar intervals. These snapshots can be restored at a later date to undo all changes to the system.")

            QQC2.Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Install Timeshift"
            }


            QQC2.Button {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: Kirigami.Units.gridUnit * 3
                anchors.horizontalCenter: parent.horizontalCenter

                icon.name: "go-previous-view"
                text: i18nc("@action:button", "Go Back")
                onClicked: pageStack.layers.pop();
            }
        }
    }
}


