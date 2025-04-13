import QtQuick 2.15

Item {
    id: stick
    width: 150
    height: 150

    signal joystickMoved(real dx, real dy)

    Rectangle {
        id: base
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        radius: width / 2
        color: "#555"

        Rectangle {
            id: knob
            width: 60
            height: 60
            radius: width / 2
            color: "#ccc"
            opacity: 0.9
            // now allows center to go slightly outside
        property real maxDist: (base.width - width) / 2 + (width / 2)


        }
        MultiPointTouchArea {
            id: area
            anchors.fill: parent

            touchPoints: [
                TouchPoint { id: tp1 },
                TouchPoint { id: tp2 }
            ]

            onTouchUpdated: {

                var tp1 = area.touchPoints[0];
                if (tp1.pressed || tp1.updated) {
                var dx = tp1.x - base.width / 2;
                var dy = tp1.y - base.height / 2;

                var distance = Math.sqrt(dx * dx + dy * dy);
                var clampedDx = dx;
                var clampedDy = dy;

                // Clamp only if it's past allowed radius (center can go out by half knob size)
                if (distance > knob.maxDist) {
                    var angle = Math.atan2(dy, dx);
                    clampedDx = Math.cos(angle) * knob.maxDist;
                    clampedDy = Math.sin(angle) * knob.maxDist;
                }

                knob.x = base.width / 2 + clampedDx - knob.width / 2;
                knob.y = base.height / 2 + clampedDy - knob.height / 2;

                // normalize relative to normal movement range (original base radius)
                var actualMax = (base.width - knob.width) / 2;

               // stick.joystickMoved(clampedDx / actualMax, clampedDy / actualMax);

                var pX =(clampedDx / (base.width / 2)) * 32767;
                var pY =(clampedDy / (base.height / 2)) * 32767;

                stick.joystickMoved(pX, pY);
            }


            }

            onReleased: {
                // Reset the knob to the center when the touch is released

                knob.x = base.width / 2 - knob.width / 2;
                knob.y = base.height / 2 - knob.height / 2;
                stick.joystickMoved(0, 0)  // Reset movement signal
            }
        }
    }



    Component.onCompleted: {
        knob.x = base.width / 2 - knob.width / 2
        knob.y = base.height / 2 - knob.height / 2
    }
}
