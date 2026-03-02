
import QtQuick
import Quickshell.Io
import "." as Notifs

Item {
    id: root

    signal dismissed
    required property var notif
    property var screen: Qt.size(1920, 1080)
    property var lifetime: 5000

    enum AnimState {
        Inert,
        Flinging,
        Dismissing
    }
    property var state: Notif.Inert
    property var isDragging: false

    property var velocityX: 0
    property var velocityY: 0
    property var velocityR: 0

    FrameAnimation {
        running: root.state != Notif.Inert
        onTriggered: {
            if (root.state == Notif.Dismissing) {
                root.velocityX += frameTime * 20000;

                if (display.x > display.width) {
                    root.dismissed();
                }
            } else if (root.state == Notif.Flinging) {
                root.velocityY += 3000 * frameTime;
                display.rotation = -root.velocityY * frameTime;

                knight.visible = true;
                knight.x += root.velocityX * frameTime;
                knight.y += root.velocityY * frameTime;
                knight.rotation += root.velocityX * 0.2 * frameTime;

                if (display.x > display.width || display.y > root.screen.height) {
                    root.dismissed();
                }
            }

            display.x += root.velocityX * frameTime;
            display.y += root.velocityY * frameTime;
            display.rotation += root.velocityR * frameTime;
        }
    }

    implicitWidth: display.width
    implicitHeight: display.height
    anchors.fill: display

    Notifs.Display {
        id: display
        notif: root.notif
        x: 0
        y: 0
        rotation: 0
        transformOrigin: Item.Right
    }

    MouseArea {
        id: mouseArea
        anchors.fill: display
        acceptedButtons: Qt.RightButton
        enabled: true

        onClicked: e => {
            if (enabled && e.button & Qt.RightButton) {
                root.state = Notif.Dismissing;
            }
        }
    }

    Timer {
        id: timer
        interval: root.lifetime
        repeat: false
        running: !mouseArea.containsMouse && root.state == Notif.Inert
        onTriggered: () => {
            root.state = Notif.Dismissing;
        }
    }

    Process {
        id: playSoundCmd
        command: ["play", "--no-show-progress", "~/nixos/dotfiles/quickshell/notifs/meow.mp3"]
    }

    Component.onCompleted: playSoundCmd.startDetached()
}