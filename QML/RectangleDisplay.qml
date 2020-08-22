import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3

Rectangle {
    id:bigBoss

    property int value: 30
    width : 585
    height: 298

    Rectangle {
        id: theHeaderRectangle
        width: parent.width
        height: 42
        color: "#cafafe"

        Text {
            id: sensorTitle
            width: 177
            height: 18
            text: qsTr("Temperature - The right Corner")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 12
        }

        Rectangle {
            id: activityCircle
            width: 11
            height: 11
            color: "#00ff4e"
            radius: 5
            anchors.left: sensorTitle.right
            anchors.leftMargin: 120
            border.width: 0
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            z: 0
        }

        Text {
            id: theLastActiveTime
            width: 34
            height: 15
            color: "#00ff4e"
            text: qsTr("12:10")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: activityCircle.right
            anchors.leftMargin: 10
            font.pixelSize: 12
        }
    }

    StackView{
        id:stack
        width: parent.width
        height: parent.height-theHeaderRectangle.height
        anchors.top: theHeaderRectangle.bottom
        anchors.topMargin: 0
        initialItem: theBodyRectangle

        Component{
            id: theBodyRectangle


            Rectangle {

                visible: false
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop {
                        position: 0
                        color: "#55bcc9"
                    }

                    GradientStop {
                        position: 1
                        color: "#3feee6"
                    }
                }

                Button {
                    id: refreshButton
                    width: 77
                    height: 29
                    text: qsTr("Refresh")
                    anchors.left: parent.left
                    anchors.leftMargin: 48
                    anchors.verticalCenterOffset: -19
                    anchors.verticalCenter: parent.verticalCenter
                    background: Rectangle{
                        anchors.fill: parent
                        color: "#CAFAFE"
                    }
                }

                CustomGauge{
                    value: bigBoss.value
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }

                Button {
                    id: historyButton
                    width: 77
                    height: 29
                    text: qsTr("History")
                    anchors.right: parent.right
                    anchors.rightMargin: 48
                    anchors.verticalCenterOffset: 0
                    anchors.verticalCenter: refreshButton.verticalCenter
                    background: Rectangle{
                        anchors.fill: parent
                        color: "#CAFAFE"
                    }
                    onClicked: {
                        stack.push(chart)
                    }
                }

                Text {
                    id: info
                    width: 549
                    height: 15
                    text: qsTr("Status :  Active          Caution Range     :    20  - 40 °C      Captive Capacity :  -10 - 100 °C         Station Id :  0sa21ed
        ")
                    anchors.bottomMargin: 10
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 10
                }
            }
        }

        Component{
            id:chart

            Rectangle{

                anchors.fill:parent
                visible: false
                Text {
                    id: name
                    text: qsTr("The Chart Area")
                    anchors.centerIn: parent
                    font.pointSize: 36
                }
                color: "red"

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        stack.push(theBodyRectangle)
                    }
                }
            }
        }
    }
}





/*##^##
Designer {
    D{i:4;anchors_x:566}D{i:9;anchors_x:38}D{i:5;anchors_y:43}
}
##^##*/
