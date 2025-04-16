import QtQuick 2.15

Item {
    id: stick
    width: 150
    height: 150

    signal joystickMoved(real dx, real dy)

    property real startX: 0
    property real startY: 0

    property int mode: 0

    onModeChanged: {
        if(mode == 1) {
            base.border.color = "red"
        } else if(mode == 2) {
            base.border.color = "blue"
        } else {
            base.border.color = "gray"
        }
    }

    function drag(tp) {
        console.log(tp.x);
        let dx = tp.x - stick.startX
        let dy = tp.y - stick.startY
        stick.x += dx - stick.width / 2
        stick.y += dy - stick.height / 2


        // Update start position to new touch point for smooth dragging
        //roundButton.startX = tp[0].x
        //roundButton.startY = tp[0].y
    }

    function resize(tp) {

        let dx = tp.x - stick.startX
        let dy = tp.x - stick.startX
        if(dx > 50 && dy > 50) {
            stick.width = dx
            knob.width = dx * 0.4
            stick.height = dy
            knob.height = dy * 0.4
        }
    }

    Rectangle {
        id: base
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        radius: width / 2
        color: "#555"
        opacity: 0.6

        Rectangle {
            id: knob
            width: base.width * 0.4
            height: base.height * 0.4
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
                if(mode == 0) {
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

                } else if(mode == 1) {
                    console.log("drag")
                    drag(tp1);
                } else {
                    console.log("resize")
                    resize(tp1);
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
