import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import Qt.labs.settings 1.1 // Important for Settings


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

    // Define a Settings object
    Settings {
        id: appSettings
        category: "uiPositions"
        property int leftStick_X
        property int leftStick_Y

        property int rightStick_X
        property int rightStick_Y

        property int btnA_X
        property int btnB_X
        property int btnX_X
        property int btnY_X
        property int btnTL_X
        property int btnTL2_X
        property int btnTR_X
        property int btnTR2_X
        property int btnSelect_X
        property int btnStart_X
        property int btnDpadUp_X
        property int btnDpadDown_X
        property int btnDpadLeft_X
        property int btnDpadRight_X

        property int btnA_Y
        property int btnB_Y
        property int btnX_Y
        property int btnY_Y
        property int btnTL_Y
        property int btnTL2_Y
        property int btnTR_Y
        property int btnTR2_Y
        property int btnSelect_Y
        property int btnStart_Y
        property int btnDpadUp_Y
        property int btnDpadDown_Y
        property int btnDpadLeft_Y
        property int btnDpadRight_Y
    }
    function savePosition() {

        appSettings.leftStick_X = leftStick.x;
        appSettings.leftStick_Y = leftStick.y;

        appSettings.rightStick_X = rightStick.x;
        appSettings.rightStick_Y = rightStick.y;

        appSettings.btnA_X = btnA.x
        appSettings.btnB_X = btnB.x
        appSettings.btnX_X = btnX.x
        appSettings.btnY_X = btnY.x
        appSettings.btnTL_X = btnTL.x
        appSettings.btnTL2_X = btnTL2.x
        appSettings.btnTR_X = btnTR.x
        appSettings.btnTR2_X = btnTR2.x
        appSettings.btnSelect_X = btnSelect.x
        appSettings.btnStart_X = btnStart.x
        appSettings.btnDpadUp_X = btnDpadUp.x
        appSettings.btnDpadDown_X = btnDpadDown.x
        appSettings.btnDpadLeft_X = btnDpadLeft.x
        appSettings.btnDpadRight_X = btnDpadRight.x

        appSettings.btnA_Y = btnA.y
        appSettings.btnB_Y = btnB.y
        appSettings.btnX_Y = btnX.y
        appSettings.btnY_Y = btnY.y
        appSettings.btnTL_Y = btnTL.y
        appSettings.btnTL2_Y = btnTL2.y
        appSettings.btnTR_Y = btnTR.y
        appSettings.btnTR2_Y = btnTR2.y
        appSettings.btnSelect_Y = btnSelect.y
        appSettings.btnStart_Y = btnStart.y
        appSettings.btnDpadUp_Y = btnDpadUp.y
        appSettings.btnDpadDown_Y = btnDpadDown.y
        appSettings.btnDpadLeft_Y = btnDpadLeft.y
        appSettings.btnDpadRight_Y = btnDpadRight.y

    }

    // Load the button code "struct"
    ButtonCodes {
        id: buttons
    }


        // LEFT JOYSTICK
        Joystick {
            id: leftStick
            x: appSettings.leftStick_X || null
            y: appSettings.leftStick_Y || null
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins:  parent.width * 0.05
            onJoystickMoved: joystick.moveAxisXY(dx, dy)
        }

        // RIGHT JOYSTICK
        Joystick {
            id: rightStick
            x: appSettings.rightStick_X || null
            y: appSettings.rightStick_Y || null
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins:  parent.width * 0.05
            onJoystickMoved: joystick.moveAxisRXY(dx, dy)
        }

        // BUTTONS (A, B, X, Y)
        RoundGamepadButton {
            id: btnA
            x: appSettings.btnA_X || null
            y: appSettings.btnA_Y || null
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
            x: appSettings.btnB_X || null
            y: appSettings.btnB_Y || null
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
            x: appSettings.btnX_X || null
            y: appSettings.btnX_Y || null
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
            x: appSettings.btnY_X || null
            y: appSettings.btnY_Y || null
            label: "Y"
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: parent.height * 0.4
            anchors.rightMargin: parent.width * 0.15
            onButtonPressed: joystick.button(buttons.btn_Y, 1)
            onButtonReleased: joystick.button(buttons.btn_Y, 0)
        }

        RectangularGamepadButton {
            id: btnExit
            label: "Exit"
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: parent.height * 0.01
            anchors.rightMargin: parent.width * 0.01
            onButtonPressed: Qt.quit()
        }
        RectangularGamepadButton {
            id: btnSave
            label: "Save"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: parent.height * 0.01
            anchors.leftMargin: parent.width * 0.01
            onButtonPressed: savePosition()
        }
        RectangularGamepadButton {
            id: btnDpadUp
            x: appSettings.btnDpadUp_X || null
            y: appSettings.btnDpadUp_Y || null
            label: "↑"
            width: 80
            height: 160
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: parent.height * 0.4
            anchors.leftMargin: parent.width * 0.15
            onButtonPressed: joystick.button(buttons.btn_DPAD_UP, 1)
            onButtonReleased: joystick.button(buttons.btn_DPAD_UP, 0)
        }
        RectangularGamepadButton {
            id: btnDpadDown
            x: appSettings.btnDpadDown_X || null
            y: appSettings.btnDpadDown_Y || null
            label: "↓"
            width: 80
            height: 160
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: parent.height * 0.6
            anchors.leftMargin: parent.width * 0.15
            onButtonPressed: joystick.button(buttons.btn_DPAD_DOWN, 1)
            onButtonReleased: joystick.button(buttons.btn_DPAD_DOWN, 0)
        }
        RectangularGamepadButton {
            id: btnDpadRight
            x: appSettings.btnDpadRight_X || null
            y: appSettings.btnDpadRight_Y || null
            label: "→"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: parent.height * 0.5
            anchors.leftMargin: parent.width * 0.2
            onButtonPressed: joystick.button(buttons.btn_DPAD_RIGHT, 1)
            onButtonReleased: joystick.button(buttons.btn_DPAD_RIGHT, 0)
        }
        RectangularGamepadButton {
            id: btnDpadLeft
            x: appSettings.btnDpadLeft_X || null
            y: appSettings.btnDpadLeft_Y || null
            label: "←"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: parent.height * 0.5
            anchors.leftMargin: parent.width * 0.1
            onButtonPressed: joystick.button(buttons.btn_DPAD_LEFT, 1)
            onButtonReleased: joystick.button(buttons.btn_DPAD_LEFT, 0)
        }
        RectangularGamepadButton {
            id: btnStart
            x: appSettings.btnStart_X || null
            y: appSettings.btnStart_Y || null
            label: "Start"
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.bottomMargin: parent.height * 0.1
            anchors.leftMargin: parent.width * 0.4
            onButtonPressed: joystick.button(buttons.btn_START, 1)
            onButtonReleased: joystick.button(buttons.btn_START, 0)
        }
        RectangularGamepadButton {
            id: btnSelect
            x: appSettings.btnSelect_X || null
            y: appSettings.btnSelect_Y || null
            label: "Select"
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.bottomMargin: parent.height * 0.1
            anchors.rightMargin: parent.width * 0.4
            onButtonPressed: joystick.button(buttons.btn_SELECT, 1)
            onButtonReleased: joystick.button(buttons.btn_SELECT, 0)
        }
          RectangularGamepadButton {
            id: btnTL
            x: appSettings.btnTL_X || null
            y: appSettings.btnTL_Y || null
            label: "TL"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: parent.height * 0.02
            anchors.leftMargin: parent.width * 0.1
            onButtonPressed: joystick.button(buttons.btn_TL, 1)
            onButtonReleased: joystick.button(buttons.btn_TL, 0)
        }
          RectangularGamepadButton {
            id: btnTR
            x: appSettings.btnTR_X || null
            y: appSettings.btnTR_Y || null
            label: "TR"
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: parent.height * 0.02
            anchors.rightMargin: parent.width * 0.1
            onButtonPressed: joystick.button(buttons.btn_TR, 1)
            onButtonReleased: joystick.button(buttons.btn_TR, 0)
        }
          RectangularGamepadButton {
            id: btnTL2
            x: appSettings.btnTL2_X || null
            y: appSettings.btnTL2_Y || null
            label: "TL2"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: parent.height * 0.1
            anchors.leftMargin: parent.width * 0.1
            onButtonPressed: joystick.button(buttons.btn_TL2, 1)
            onButtonReleased: joystick.button(buttons.btn_TL2, 0)
        }
          RectangularGamepadButton {
            id: btnTR2
            x: appSettings.btnTR2_X || null
            y: appSettings.btnTR2_Y || null
            label: "TR2"
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: parent.height * 0.1
            anchors.rightMargin: parent.width * 0.1
            onButtonPressed: joystick.button(buttons.btn_TR2, 1)
            onButtonReleased: joystick.button(buttons.btn_TR2, 0)
        }

}
