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
    // completely transparent background
    visibility: "Maximized"
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.Tool | Qt.WindowTransparentForInput
    color: "transparent"

    // Load the button code "struct"
    ButtonCodes {
        id: buttons
    }


        // LEFT JOYSTICK
        Joystick {
            id: leftStick
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins:  parent.width * 0.05
            onJoystickMoved: joystick.moveAxisXY(dx, dy)
        }

        // RIGHT JOYSTICK
        Joystick {
            id: rightStick
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins:  parent.width * 0.05
            onJoystickMoved: joystick.moveAxisRXY(dx, dy)
        }

        // BUTTONS (A, B, X, Y)
        RoundGamepadButton {
            id: btnA
            label: "A"
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: parent.height * 0.6
            anchors.rightMargin: parent.width * 0.15
            onButtonPressed: joystick.button(buttons.btn_A, 1)
            onButtonReleased: joystick.button(buttons.btn_A, 0)

        }

        RoundGamepadButton {
            id: btnB
            label: "B"
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: parent.height * 0.5
            anchors.rightMargin: parent.width * 0.1
            onButtonPressed: joystick.button(buttons.btn_B, 1)
            onButtonReleased: joystick.button(buttons.btn_B, 0)
        }

        RoundGamepadButton {
            id: btnX
            label: "X"
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: parent.height * 0.5
            anchors.rightMargin: parent.width * 0.2
            onButtonPressed: joystick.button(buttons.btn_X, 1)
            onButtonReleased: joystick.button(buttons.btn_X, 0)
        }

        RoundGamepadButton {
            id: btnY
            label: "Y"
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: parent.height * 0.4
            anchors.rightMargin: parent.width * 0.15
            onButtonPressed: joystick.button(buttons.btn_Y, 1)
            onButtonReleased: joystick.button(buttons.btn_Y, 0)
        }

        RoundGamepadButton {
            id: btnExit
            label: "Exit"
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: parent.height * 0.01
            anchors.rightMargin: parent.width * 0.01
            onButtonPressed: Qt.quit()
        }
        RoundGamepadButton {
            id: btnDpadUp
            label: "up"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: parent.height * 0.4
            anchors.leftMargin: parent.width * 0.15
            onButtonPressed: joystick.button(buttons.btn_DPAD_UP, 1)
            onButtonReleased: joystick.button(buttons.btn_DPAD_UP, 0)
        }
        RoundGamepadButton {
            id: btnDpadDown
            label: "down"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: parent.height * 0.6
            anchors.leftMargin: parent.width * 0.15
            onButtonPressed: joystick.button(buttons.btn_DPAD_DOWN, 1)
            onButtonReleased: joystick.button(buttons.btn_DPAD_DOWN, 0)
        }
        RoundGamepadButton {
            id: btnDpadRight
            label: "right"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: parent.height * 0.5
            anchors.leftMargin: parent.width * 0.2
            onButtonPressed: joystick.button(buttons.btn_DPAD_RIGHT, 1)
            onButtonReleased: joystick.button(buttons.btn_DPAD_RIGHT, 0)
        }
        RoundGamepadButton {
            id: btnDpadLeft
            label: "left"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: parent.height * 0.5
            anchors.leftMargin: parent.width * 0.1
            onButtonPressed: joystick.button(buttons.btn_DPAD_LEFT, 1)
            onButtonReleased: joystick.button(buttons.btn_DPAD_LEFT, 0)
        }
        RoundGamepadButton {
            id: btnStart
            label: "Start"
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.bottomMargin: parent.height * 0.1
            anchors.leftMargin: parent.width * 0.4
            onButtonPressed: joystick.button(buttons.btn_START, 1)
            onButtonReleased: joystick.button(buttons.btn_START, 0)
        }
        RoundGamepadButton {
            id: btnSelect
            label: "Select"
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.bottomMargin: parent.height * 0.1
            anchors.rightMargin: parent.width * 0.4
            onButtonPressed: joystick.button(buttons.btn_SELECT, 1)
            onButtonReleased: joystick.button(buttons.btn_SELECT, 0)
        }
          RoundGamepadButton {
            id: btnTL
            label: "TL"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: parent.height * 0.02
            anchors.leftMargin: parent.width * 0.1
            onButtonPressed: joystick.button(buttons.btn_TL, 1)
            onButtonReleased: joystick.button(buttons.btn_TL, 0)
        }
          RoundGamepadButton {
            id: btnTR
            label: "TR"
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: parent.height * 0.02
            anchors.rightMargin: parent.width * 0.1
            onButtonPressed: joystick.button(buttons.btn_TR, 1)
            onButtonReleased: joystick.button(buttons.btn_TR, 0)
        }
          RoundGamepadButton {
            id: btnTL2
            label: "TL2"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: parent.height * 0.1
            anchors.leftMargin: parent.width * 0.1
            onButtonPressed: joystick.button(buttons.btn_TL2, 1)
            onButtonReleased: joystick.button(buttons.btn_TL2, 0)
        }
          RoundGamepadButton {
            id: btnTR2
            label: "TR2"
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: parent.height * 0.1
            anchors.rightMargin: parent.width * 0.1
            onButtonPressed: joystick.button(buttons.btn_TR2, 1)
            onButtonReleased: joystick.button(buttons.btn_TR2, 0)
        }

}
