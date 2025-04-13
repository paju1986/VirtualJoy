import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: roundButton
    property alias label: roundButtonLabel.text

    width: 80
    height: 80

    background: Rectangle {
        color: "#4CAF50"
        radius: width / 2
        border.color: "#222"
        border.width: 2
    }

    contentItem: Text {
        id: roundButtonLabel
        anchors.centerIn: parent
        text: "A"
        color: "white"
        font.bold: true
        font.pixelSize: 24
    }
}
