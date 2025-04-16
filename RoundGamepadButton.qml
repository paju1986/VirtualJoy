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

    //feedback of current mode by changing border color
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
        //function for drag functionality on move mode
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
        //funtion for resize funtionality on resize mode

        let dx = tp.x - roundButton.startX
        let dy = tp.y - roundButton.startY
        if(dx > 50 && dy > 50) {
            roundButton.width = dx

            roundButton.height = dy
        }
    }

    background: Rectangle {
        color: "transparent"
        opacity:0.6
        id: body
        radius: width / 2
        border.color: "gray"
        border.width: 4
    }

    contentItem: Text {
        id: roundButtonLabel
        anchors.centerIn: parent
        text: "A"
        color: "grey"
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
                if(mode == 0) { //controls behaviour on different modes
                    if (tp1.pressed || tp1.updated) {
                      roundButton.buttonPressed();
                      //feedback for touch
                      body.color = "white"
                      body.opacity = 1
                    }
                    else {
                        roundButton.buttonReleased();
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
