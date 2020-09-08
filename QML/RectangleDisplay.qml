import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3

Rectangle {
    id:bigBoss

    property string title: "Sensor"
    property int value: 00
    property int captiveMax: 0
    property int captiveMin: 0
    property int cautionMax: 0
    property int cautionMin: 0
    property string station: "value"
    property string unit: "°C"
    property string lastActiveTime: "Undefined"

    //width : 585
    //height: 298

    width:380
    height:194

    //Signal Handlers

    //When the value changes
    onValueChanged: {
        /*
        if ((value < cautionMin || value > cautionMax) && gradientChangeableColor.color !== "#FFC400"){
            gradientColorAnimation.to = "#FFC400"
            gradientColorAnimation.start()
        }else if((value >= cautionMin && value <= cautionMax) && gradientChangeableColor.color !== "#3feee6"){
            gradientColorAnimation.to = "#3feee6"
            gradientColorAnimation.start()
        }else{
            //Does nothing let's the colors the way they are
        }*/

        //Updates the last time that we received data from the server.
    }

    Rectangle {
        id: theHeaderRectangle
        width: parent.width
        height: 42
        color: "#cafafe"

        Text {
            id: sensorTitle
            height: 18
            text: title
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
            anchors.left: theLastActiveTime.left
            anchors.leftMargin: -20
            border.width: 0
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: theLastActiveTime
            width: 34
            height: 15
            color: "#00ff4e"
            text: lastActiveTime
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: theHeaderRectangle.right
            anchors.rightMargin: 20
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
                        id:gradientChangeableColor
                        position: 1
                        color: (value < cautionMin || value > cautionMax) ?  "#FFC400" : "#3feee6"
                    }
                }

                Button {
                    id: refreshButton
                    width: 60
                    height: 24
                    text: qsTr("Refresh")
                    font.pointSize: 12
                    anchors.left: parent.left
                    anchors.leftMargin: 24
                    anchors.verticalCenter: parent.verticalCenter
                    background: Rectangle{
                        anchors.fill: parent
                        color: "#CAFAFE"
                    }
                }

                CustomGauge{
                    value: bigBoss.value
                    captiveMax: bigBoss.captiveMax
                    captiveMin: bigBoss.captiveMin
                    cautionMax: bigBoss.cautionMax
                    cautionMin: bigBoss.cautionMin
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }

                Button {
                    id: historyButton
                    width: 60
                    height: 24
                    text: qsTr("History")
                    font.pointSize: 12
                    anchors.right: parent.right
                    anchors.rightMargin: 24
                    anchors.verticalCenter: refreshButton.verticalCenter
                    background: Rectangle{
                        anchors.fill: parent
                        color: "#CAFAFE"
                    }
                    onClicked: {
                        stack.push(chart)
                    }
                }

                //This text has to be turned into a Row Layout that way the text can always fillthe parent width
                Text {
                    id: info
                    width: parent.width
                    height: 15
                    text: qsTr("Status : Active   Caution Range  :  "+cautionMin+"-"+cautionMax+unit+"    "+"Captive Capacity  :  " + captiveMin+"-"+captiveMax+unit+"      Station Id  :  " + station)
                    anchors.bottomMargin: 10
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 7
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
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


