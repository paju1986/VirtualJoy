import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

Window {
    id: root
    visible: true
    width: 800
    height: 480
    title: qsTr("Virtual Gamepad")

    Rectangle {
        anchors.fill: parent
        color: "#202020"

        // LEFT JOYSTICK
        Joystick {
            id: leftStick
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins:  parent.width * 0.05
            onJoystickMoved: joystick.moveAxis(dx, dy)
        }

        // RIGHT JOYSTICK
        Joystick {
            id: rightStick
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins:  parent.width * 0.05
            onJoystickMoved: console.log("Right joystick:", dx, dy)
        }

        // BUTTONS (A, B, X, Y)
        RoundGamepadButton {
            id: btnA
            label: "A"
            anchors.right: parent.right
            anchors.top: parent.verticalCenter
            anchors.rightMargin: parent.width * 0.1
            anchors.topMargin: -parent.height * 0.05
            onClicked: console.log("A pressed")
        }

        RoundGamepadButton {
            id: btnB
            label: "B"
            anchors.right: parent.right
            anchors.top: btnA.bottom
            anchors.topMargin: parent.height * 0.02
            anchors.rightMargin: parent.width * 0.06
            onClicked: console.log("B pressed")
        }

        RoundGamepadButton {
            id: btnX
            label: "X"
            anchors.right: btnA.left
            anchors.rightMargin: parent.width * 0.04
            anchors.verticalCenter: btnA.verticalCenter
            onClicked: console.log("X pressed")
        }

        RoundGamepadButton {
            id: btnY
            label: "Y"
            anchors.bottom: btnA.top
            anchors.bottomMargin: parent.height * 0.02
            anchors.right: btnA.right
            onClicked: console.log("Y pressed")
        }
    }
}
