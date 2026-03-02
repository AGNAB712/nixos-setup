import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications

Item {
    id: root

    required property Notification notif

    implicitWidth: 240
    implicitHeight: layout.height

    ColumnLayout {
        id: layout

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 10


        spacing: 5

        Rectangle {
            id: bannerRect
            color: "#314734"
            Layout.fillWidth: true
            implicitHeight: textColumn.height + 10
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            border.width: 2
            border.color: "white"

            // Make bannerRect a RowLayout that contains text and icon at bottom right
            RowLayout {
                anchors.fill: parent
                anchors.margins: 5

                ColumnLayout {
                    id: textColumn
                    Layout.fillWidth: true

                    Text {
                        text: root.notif.summary
                        font.family: "FreeMono"
                        wrapMode: Text.Wrap
                        font.pointSize: 13
                        font.bold: true
                        color: "#ffffffff"
                        Layout.fillWidth: true
                    }

                    Text {
                        text: root.notif.body
                        font.family: "FreeMono"
                        wrapMode: Text.Wrap
                        font.pointSize: 10
                        font.bold: true
                        color: "#ffffffff"
                        Layout.fillWidth: true
                    }
                }

                Rectangle {
                    width: 48
                    height: 48
                    color: "transparent"
                    Layout.alignment: Qt.AlignBottom | Qt.AlignRight

                    Image {
                        anchors.fill: parent
                        source: "./icon.png"
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                    }
                }
            }
        }
    }
}