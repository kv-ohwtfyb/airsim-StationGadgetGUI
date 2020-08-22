import QtQuick 2.14
import QtQuick.Controls 2.14

Page {
    id:page

    Rectangle{
        id:theRectangle
        width: 500
        height: 678
        color: "#3FEEE6"

        anchors.centerIn: parent

        Label{
            id:airsimLabel
            anchors.top: parent.top
            anchors.topMargin: 130
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Airsim - Login"
            font.pointSize: 34
            font.family: "Helvetica Neue"
            font.bold: true
        }

        Rectangle{
            id:thePassInputRectangle
            anchors.top: airsimLabel.bottom
            anchors.topMargin: 100
            anchors.horizontalCenter: parent.horizontalCenter
            width:308
            height: 46
            color: "white"
            anchors.horizontalCenterOffset: 0

            TextInput{
                id:thePassInput
                width: parent.width
                height: parent.height
                anchors.fill: parent.fill
                font.pointSize: 28
                color: "grey"
                echoMode: TextInput.PasswordEchoOnEdit
                onFocusChanged: {
                    page.parent.user = thePassInput.text
                }
            }
        }

        Button{
            id:loginButton
            anchors.top: thePassInputRectangle.bottom
            anchors.topMargin: 76
            anchors.horizontalCenter: parent.horizontalCenter
            width: 98
            height: 36
            text: "Login"
            font.pointSize: 24
            background: Rectangle{
                anchors.fill: parent
                color: "#CAFAFE"
            }
            onClicked: {
                //page.parent.connectToServer("https://airsim.herokuapp.com")
            }
        }

        BusyIndicator{
            id : busyIndicatorId
            width: parent.width
            anchors.top: loginButton.bottom
            anchors.topMargin: 50
            running: false
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:800;width:1280}
}
##^##*/