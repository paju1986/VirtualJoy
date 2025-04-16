import QtQuick 6.4
import QtQuick.Controls 6.4
import QtQuick.Layouts 6.4
import QtQuick.Window 6.4
import Qt.labs.settings 1.0


Window {
    id: root
    visible: true
    width: 800
    height: 480
    title: qsTr("VirtualJoy")
    // completely transparent background
    visibility: "Maximized"
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.Tool //| Qt.WindowTransparentForInput
    color: "transparent"

    property int mode: 0

    // Define a Settings object
    Settings {
        id: appSettings
        category: "uiPositions"
        property int leftStick_X
        property int leftStick_Y

        property int leftStick_W

        property int rightStick_X
        property int rightStick_Y

        property int rightStick_W

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

        property int btnA_W
        property int btnB_W
        property int btnX_W
        property int btnY_W
        property int btnTL_W
        property int btnTL2_W
        property int btnTR_W
        property int btnTR2_W
        property int btnSelect_W
        property int btnStart_W
        property int btnDpadUp_W
        property int btnDpadDown_W
        property int btnDpadLeft_W
        property int btnDpadRight_W

        property int btnA_H
        property int btnB_H
        property int btnX_H
        property int btnY_H
        property int btnTL_H
        property int btnTL2_H
        property int btnTR_H
        property int btnTR2_H
        property int btnSelect_H
        property int btnStart_H
        property int btnDpadUp_H
        property int btnDpadDown_H
        property int btnDpadLeft_H
        property int btnDpadRight_H
    }
    function savePosition() {

        //Saving x and y and with and height of all controls to config file
        appSettings.leftStick_X = leftStick.x;
        appSettings.leftStick_Y = leftStick.y;
        appSettings.leftStick_W = leftStick.width;

        appSettings.rightStick_X = rightStick.x;
        appSettings.rightStick_Y = rightStick.y;

        appSettings.rightStick_W = rightStick.width;

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

        appSettings.btnA_W = btnA.width
        appSettings.btnB_W = btnB.width
        appSettings.btnX_W = btnX.width
        appSettings.btnY_W = btnY.width
        appSettings.btnTL_W = btnTL.width
        appSettings.btnTL2_W = btnTL2.width
        appSettings.btnTR_W = btnTR.width
        appSettings.btnTR2_W = btnTR2.width
        appSettings.btnSelect_W = btnSelect.width
        appSettings.btnStart_W = btnStart.width
        appSettings.btnDpadUp_W = btnDpadUp.width
        appSettings.btnDpadDown_W = btnDpadDown.width
        appSettings.btnDpadLeft_W = btnDpadLeft.width
        appSettings.btnDpadRight_W = btnDpadRight.width

        appSettings.btnA_H = btnA.height
        appSettings.btnB_H = btnB.height
        appSettings.btnX_H = btnX.height
        appSettings.btnY_H = btnY.height
        appSettings.btnTL_H = btnTL.height
        appSettings.btnTL2_H = btnTL2.height
        appSettings.btnTR_H = btnTR.height
        appSettings.btnTR2_H = btnTR2.height
        appSettings.btnSelect_H = btnSelect.height
        appSettings.btnStart_H = btnStart.height
        appSettings.btnDpadUp_H = btnDpadUp.height
        appSettings.btnDpadDown_H = btnDpadDown.height
        appSettings.btnDpadLeft_H = btnDpadLeft.height
        appSettings.btnDpadRight_H = btnDpadRight.height

    }

    function changeMode() {
        //Changing between normal, move and resize modes
        console.log(root.mode)
        if(root.mode == 0) {
            message.text = "Move mode"
            message.color = "red"
            root.mode = 1;
            console.log("Move mode")
        } else if(root.mode == 1) {
            root.mode = 2;
            message.text = "Resize mode"
            message.color = "blue"
            console.log("Resize mode")
            root.savePosition();
        } else {
            message.text = ""
            root.mode = 0;
            console.log("Normal mode")
            root.savePosition();
        }
    }

    // Load the button code "struct"
    ButtonCodes {
        id: buttons
    }

    // Message for showing current mode
    Text {
        id: message
        text: ""
        font.pixelSize: 32
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.top * 0.2
    }


        // LEFT JOYSTICK
        Joystick {
            id: leftStick
            x: appSettings.leftStick_X || null
            y: appSettings.leftStick_Y || null
            width: appSettings.leftStick_W || null
            height: appSettings.leftStick_W || null
            mode: root.mode
            onJoystickMoved: joystick.moveAxisXY(dx, dy)
        }

        // RIGHT JOYSTICK
        Joystick {
            id: rightStick
            x: appSettings.rightStick_X || null
            y: appSettings.rightStick_Y || null
            width: appSettings.rightStick_W || null
            height: appSettings.rightStick_W || null
            mode: root.mode
            onJoystickMoved: joystick.moveAxisRXY(dx, dy)
        }

        // BUTTONS (A, B, X, Y)
        RoundGamepadButton {
            id: btnA
            x: appSettings.btnA_X || null
            y: appSettings.btnA_Y || null
            width: appSettings.btnA_W || null
            height: appSettings.btnA_H || null
            label: "A"
            mode: root.mode
            // anchors.top: parent.top
            // anchors.right: parent.right
            // anchors.topMargin: parent.height * 0.6
            // anchors.rightMargin: parent.width * 0.15
            onButtonPressed: joystick.button(buttons.btn_A, 1)
            onButtonReleased: joystick.button(buttons.btn_A, 0)

        }

        RoundGamepadButton {
            id: btnB
            x: appSettings.btnB_X || null
            y: appSettings.btnB_Y || null
            width: appSettings.btnB_W || null
            height: appSettings.btnB_H || null
            label: "B"
            mode: root.mode
            onButtonPressed: joystick.button(buttons.btn_B, 1)
            onButtonReleased: joystick.button(buttons.btn_B, 0)
        }

        RoundGamepadButton {
            id: btnX
            x: appSettings.btnX_X || null
            y: appSettings.btnX_Y || null
            width: appSettings.btnX_W || null
            height: appSettings.btnX_H || null
            label: "X"
            mode: root.mode
            onButtonPressed: joystick.button(buttons.btn_X, 1)
            onButtonReleased: joystick.button(buttons.btn_X, 0)
        }

        RoundGamepadButton {
            id: btnY
            x: appSettings.btnY_X || null
            y: appSettings.btnY_Y || null
            width: appSettings.btnY_W || null
            height: appSettings.btnY_H || null
            label: "Y"
            mode: root.mode
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
            id: btnMode
            label: "Mode"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: parent.height * 0.01
            anchors.leftMargin: parent.width * 0.01
            onButtonReleased: changeMode();
        }
        RectangularGamepadButton {
            id: btnDpadUp
            x: appSettings.btnDpadUp_X || null
            y: appSettings.btnDpadUp_Y || null
            width: appSettings.btnDpadUp_W || null
            height: appSettings.btnDpadUp_H || null
            label: "↑"
            mode: root.mode
            onButtonPressed: joystick.button(buttons.btn_DPAD_UP, 1)
            onButtonReleased: joystick.button(buttons.btn_DPAD_UP, 0)
        }
        RectangularGamepadButton {
            id: btnDpadDown
            x: appSettings.btnDpadDown_X || null
            y: appSettings.btnDpadDown_Y || null
            width: appSettings.btnDpadDown_W || null
            height: appSettings.btnDpadDown_H || null
            label: "↓"
            mode: root.mode
            onButtonPressed: joystick.button(buttons.btn_DPAD_DOWN, 1)
            onButtonReleased: joystick.button(buttons.btn_DPAD_DOWN, 0)
        }
        RectangularGamepadButton {
            id: btnDpadRight
            x: appSettings.btnDpadRight_X || null
            y: appSettings.btnDpadRight_Y || null
            width: appSettings.btnDpadRight_W || null
            height: appSettings.btnDpadRight_H || null
            label: "→"
            mode: root.mode
            onButtonPressed: joystick.button(buttons.btn_DPAD_RIGHT, 1)
            onButtonReleased: joystick.button(buttons.btn_DPAD_RIGHT, 0)
        }
        RectangularGamepadButton {
            id: btnDpadLeft
            x: appSettings.btnDpadLeft_X || null
            y: appSettings.btnDpadLeft_Y || null
            width: appSettings.btnDpadLeft_W || null
            height: appSettings.btnDpadLeft_H || null
            label: "←"
            mode: root.mode
            onButtonPressed: joystick.button(buttons.btn_DPAD_LEFT, 1)
            onButtonReleased: joystick.button(buttons.btn_DPAD_LEFT, 0)
        }
        RectangularGamepadButton {
            id: btnStart
            x: appSettings.btnStart_X || null
            y: appSettings.btnStart_Y || null
            width: appSettings.btnStart_W || null
            height: appSettings.btnStart_H || null
            label: "Start"
            mode: root.mode
            onButtonPressed: joystick.button(buttons.btn_START, 1)
            onButtonReleased: joystick.button(buttons.btn_START, 0)
        }
        RectangularGamepadButton {
            id: btnSelect
            x: appSettings.btnSelect_X || null
            y: appSettings.btnSelect_Y || null
            width: appSettings.btnSelect_W || null
            height: appSettings.btnSelect_H || null
            label: "Select"
            mode: root.mode
            onButtonPressed: joystick.button(buttons.btn_SELECT, 1)
            onButtonReleased: joystick.button(buttons.btn_SELECT, 0)
        }
          RectangularGamepadButton {
            id: btnTL
            x: appSettings.btnTL_X || null
            y: appSettings.btnTL_Y || null
            width: appSettings.btnTL_W || null
            height: appSettings.btnTL_H || null
            label: "TL"
            mode: root.mode
            onButtonPressed: joystick.button(buttons.btn_TL, 1)
            onButtonReleased: joystick.button(buttons.btn_TL, 0)
        }
          RectangularGamepadButton {
            id: btnTR
            x: appSettings.btnTR_X || null
            y: appSettings.btnTR_Y || null
            width: appSettings.btnTR_W || null
            height: appSettings.btnTR_H || null
            label: "TR"
            mode: root.mode
            onButtonPressed: joystick.button(buttons.btn_TR, 1)
            onButtonReleased: joystick.button(buttons.btn_TR, 0)
        }
          RectangularGamepadButton {
            id: btnTL2
            x: appSettings.btnTL2_X || null
            y: appSettings.btnTL2_Y || null
            width: appSettings.btnTL2_W || null
            height: appSettings.btnTL2_H || null
            label: "TL2"
            mode: root.mode
            onButtonPressed: joystick.button(buttons.btn_TL2, 1)
            onButtonReleased: joystick.button(buttons.btn_TL2, 0)
        }
          RectangularGamepadButton {
            id: btnTR2
            x: appSettings.btnTR2_X || null
            y: appSettings.btnTR2_Y || null
            width: appSettings.btnTR2_W || null
            height: appSettings.btnTR2_H || null
            label: "TR2"
            mode: root.mode
            onButtonPressed: joystick.button(buttons.btn_TR2, 1)
            onButtonReleased: joystick.button(buttons.btn_TR2, 0)
        }

}
