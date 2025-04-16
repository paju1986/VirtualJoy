// ButtonCodes.qml
import QtQuick 6.4
Item {
    id: buttoncodes
    // Common gamepad buttons (values taken from linux/input-event-codes.h)
    property int btn_A: 304
    property int btn_B: 305
    property int btn_X: 307
    property int btn_Y: 308
    property int btn_SELECT: 314
    property int btn_START: 315
    property int btn_MODE: 316
    property int btn_THUMBL: 317
    property int btn_THUMBR: 318
    property int btn_TL: 310
    property int btn_TR: 311
    property int btn_TL2: 312
    property int btn_TR2: 313
    property int btn_DPAD_UP: 544
    property int btn_DPAD_DOWN: 545
    property int btn_DPAD_LEFT: 546
    property int btn_DPAD_RIGHT: 547
}
