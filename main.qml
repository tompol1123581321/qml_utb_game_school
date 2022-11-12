import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Text {
        text: 'Score: ' + myRect.countOfClicks.toString()
        anchors.left: playGround.left
        anchors.bottom: playGround.top
    }

    Timer {
        id: myTimer
        interval: 2000
        running: true
        repeat: true
        onTriggered: () => {
                         const randomW = Math.random(
                             ) * (myRect.parent.width - myRect.width)
                         const randomH = Math.random(
                             ) * (myRect.parent.height - myRect.height)
                         myRect.x = randomW
                         myRect.y = randomH
                     }
    }
    Rectangle {
        id: playGround
        anchors.fill: parent
        anchors.margins: 10
        anchors.topMargin: 20
        color: 'lightGray'
        clip: true

        MouseArea {
            anchors.fill: parent
            onClicked: () => {
                           if (myRect.countOfClicks > 0) {
                               myRect.countOfClicks--
                               myTimer.interval *= 2
                               myRect.attentionColor = 'red'
                               attAnim.start()
                           }
                       }
        }

        Rectangle {

            id: myRect
            property int countOfClicks: 0
            property color attentionColor: 'yellow'
            width: parent.parent.width > 800 ? 100 : (parent.parent.width / 8)
            height: parent.parent.height > 600 ? 100 : (parent.parent.height / 6)
            visible: true
            color: this.attentionColor
            border.color: 'black'
            border.width: 2
            radius: 10
            focus: true

            Behavior on x {
                NumberAnimation {
                    duration: myTimer.interval
                    easing.type: Easing.OutElastic
                }
            }

            Behavior on y {
                NumberAnimation {
                    duration: myTimer.interval
                    easing.type: Easing.OutElastic
                }
            }

            SequentialAnimation {
                id: attAnim

                ColorAnimation {
                    from: myRect.attentionColor
                    to: "black"
                    duration: myTimer.interval / 2
                    property: 'color'
                    target: myRect
                }

                ColorAnimation {
                    from: "black"
                    to: myRect.attentionColor
                    duration: myTimer.interval / 2
                    property: 'color'
                    target: myRect
                }
            }

            Text {
                text: 'Click me'
                anchors.centerIn: parent
            }
            MouseArea {
                anchors.fill: parent
                onClicked: () => {
                               myRect.countOfClicks++
                               myTimer.interval = myTimer.interval / 2
                               myRect.attentionColor = 'green'
                               attAnim.start()
                           }
            }
        }
    }
}
