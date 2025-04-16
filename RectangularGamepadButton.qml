import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: rectangularButton
    property alias label: rectangularButtonLabel.text

    width: 160
    height: 80

    signal buttonPressed()
    signal buttonReleased()

    property real startX: 0
    property real startY: 0

    property int mode: 0

    onModeChanged: {
        if(mode == 1) {
            body.border.color = "red"
            rectangularButtonLabel.color = "red"
        } else if(mode == 2) {
            body.border.color = "blue"
            rectangularButtonLabel.color = "blue"
        } else {
            body.border.color = "gray"
            rectangularButtonLabel.color = "gray"
        }
    }

    function drag(tp) {
        console.log(tp.x);
        let dx = tp.x - rectangularButton.startX
        let dy = tp.y - rectangularButton.startY
        rectangularButton.x += dx - rectangularButton.width / 2
        rectangularButton.y += dy - rectangularButton.height / 2


        // Update start position to new touch point for smooth dragging
        //roundButton.startX = tp[0].x
        //roundButton.startY = tp[0].y
    }

    function resize(tp) {

        let dx = tp.x - rectangularButton.startX
        let dy = tp.y - rectangularButton.startY
        if(dx > 50 && dy > 50) {
            rectangularButton.width = dx

            rectangularButton.height = dy
        }
    }

    background: Rectangle {
        id: body
        color: "transparent"
        opacity:0.6
        border.width:4
        border.color: "grey"
    }

    contentItem: Text {
        id: rectangularButtonLabel
        //anchors.centerIn: parent
        text: "A"
        color: "gray"
        font.bold: true
        font.pixelSize: 24
        width: parent.width
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
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
                      rectangularButton.buttonPressed();
                      body.color = "white"
                      body.opacity = 1
                    }
                    else {
                        rectangularButton.buttonReleased();
                        body.color = "transparent"
                        body.opacity = 0.6
                    }
                } else if(mode == 1) {
                    drag(tp1);
                } else {
                    resize(tp1);
                }

            }
    }
}
