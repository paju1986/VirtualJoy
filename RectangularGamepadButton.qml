import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: rectangularButton
    property alias label: rectangularButtonLabel.text

    width: 160
    height: 80

    signal buttonPressed()
    signal buttonReleased()

    background: Rectangle {
        color: "#4CAF50"
        border.color: "#222"
        border.width: 2
    }

    contentItem: Text {
        id: rectangularButtonLabel
        //anchors.centerIn: parent
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
                if (tp1.pressed || tp1.updated) {
                      rectangularButton.buttonPressed();
                }
                else {
                    rectangularButton.buttonReleased();
                }

            }
    }
}
