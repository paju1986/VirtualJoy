import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: roundButton
    property alias label: roundButtonLabel.text

    width: 80
    height: 80

    signal buttonPressed()
    signal buttonReleased()

    property real startX: 0
    property real startY: 0

    property int mode: 0

    onModeChanged: {
        if(mode == 1) {
            body.border.color = "red"
            roundButtonLabel.color = "red"
        } else if(mode == 2) {
            body.border.color = "blue"
            roundButtonLabel.color = "blue"
        } else {
            body.border.color = "gray"
            roundButtonLabel.color = "gray"
        }
    }

    function drag(tp) {
        console.log(tp.x);
        let dx = tp.x - roundButton.startX
        let dy = tp.y - roundButton.startY
        roundButton.x += dx - roundButton.width / 2
        roundButton.y += dy - roundButton.height / 2


        // Update start position to new touch point for smooth dragging
        //roundButton.startX = tp[0].x
        //roundButton.startY = tp[0].y
    }

    function resize(tp) {

        let dx = tp.x - roundButton.startX
        let dy = tp.y - roundButton.startY
        if(dx > 50 && dy > 50) {
            roundButton.width = dx

            roundButton.height = dy
        }
    }

    background: Rectangle {
        color: "gray"
        opacity:0.5
        id: body
        radius: width / 2
        border.color: "gray"
        border.width: 2
    }

    contentItem: Text {
        id: roundButtonLabel
        anchors.centerIn: parent
        text: "A"
        color: "white"
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
                    console.log("touch")
                    if (tp1.pressed || tp1.updated) {
                      roundButton.buttonPressed();
                    }
                    else {
                        roundButton.buttonReleased();
                    }
                } else if(mode == 1) {
                    console.log("drag")
                    drag(tp1);
                } else {
                    console.log("resize")
                    resize(tp1);
                }

            }
    }
}
