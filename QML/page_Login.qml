import QtQuick 2.14
import QtQuick.Controls 2.14

Page {
    id:page

    Rectangle{
        id:theRectangle
        width: 280
        height: 400
        color: "#3FEEE6"

        anchors.centerIn: parent

        Label{
            id:airsimLabel
            anchors.top: parent.top
            anchors.topMargin: 70
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Airsim - Login"
            font.pointSize: 24
            font.family: "Helvetica Neue"
            font.bold: true
        }

        Rectangle{
            id:thePassInputRectangle
            anchors.top: airsimLabel.bottom
            anchors.topMargin: 60
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width/1.5
            height: 30
            color: "white"
            anchors.horizontalCenterOffset: 0

            TextInput{
                id:thePassInput
                width: 274
                height: parent.height
                anchors.fill: parent.fill
                font.pointSize: 28
                color: "grey"
                echoMode: TextInput.PasswordEchoOnEdit
            }
        }

        Button{

            Connections{
                target: socketFromPython

                onSignalToQML_Strings:{
                    statusText.text = statusFunction
                    if (statusText.text === "Error" || statusText.text === "Request denied by the server") {
                        busyIndicatorId.running = false
                    }
                    if (statusFunction === "Received initial files"){
                        page.parent.push("page_DataDisplay.qml")
                    }
                }
            }

            id:loginButton
            anchors.top: thePassInputRectangle.bottom
            anchors.topMargin: 76
            anchors.horizontalCenter: parent.horizontalCenter
            width: 60
            height: 30
            text: "Login"
            font.pointSize: 16
            background: Rectangle{
                anchors.fill: parent
                color: "#CAFAFE"
            }
            onClicked: {
                if (thePassInput.text.length>0){
                    socketFromPython.start(thePassInput.text)
                    busyIndicatorId.running = true
                }else{
                    statusText.text = "Please enter your password"
                }
            }
        }

        BusyIndicator{
            id : busyIndicatorId
            width: parent.width
            anchors.top: loginButton.bottom
            anchors.topMargin: 10
            running: false
        }

        Text {
            id: statusText
            anchors.top: busyIndicatorId.bottom
            anchors.topMargin: 10
            text: qsTr("")
            font.pointSize: 14
            font.family: "Helvetica Neue"
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:800}
}
##^##*/
