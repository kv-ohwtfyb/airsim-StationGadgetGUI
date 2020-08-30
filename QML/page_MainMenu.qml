import QtQuick 2.14
import QtQuick.Controls 2.14

Page {
    id:page
    title: qsTr("Page 1")

    Item{
        anchors.fill: parent

        Rectangle{
            anchors.top: parent.top
            anchors.topMargin: 20
            width: parent.width
            Text{
                text: qsTr("Menu")
                font.pointSize: 18
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Column{

            width: parent.width-40;
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.centerIn: parent
            spacing: 20

            Button{
                id:displayButton
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width-40; height:100
                text: "Display"
                font.bold: true
                font.pointSize: 29
                background: Rectangle {
                    color: "#3FEEE6"
                }
                onClicked: {
                    page.parent.replace("page_DataDisplay.qml")
                }
            }

            Button{
                id:alertsButton
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width-40; height:100
                text: "Alerts"
                font.bold: true
                font.pointSize: 29
                background: Rectangle {
                    color: "#3FEEE6"
                }
                onClicked: {
                    page.parent.replace("page_Alerts.qml")
                }
            }

            Button{
                id:configurationButton
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width-40; height:100
                text: "Configuration"
                font.bold: true
                font.pointSize: 29
                background: Rectangle {
                    color: "#3FEEE6"
                }
                onClicked: {
                    page.parent.replace("page_Configurations.qml")
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:800;width:1280}
}
##^##*/
