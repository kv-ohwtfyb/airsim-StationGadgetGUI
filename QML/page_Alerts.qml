import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQml 2.0

Page{
    id: page

    //Properties
    property string pageName: "page_Alerts"

    Rectangle{
        id:pageTitle
        width: parent.width
        height: 56
        color: "#3FEEE6"

        Row {
            width: parent.width
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter

            Text {
                id:roomTitle
                text: qsTr("Room 01")
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 20
                font.bold: true

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            Image {
                id: homeIcon
                width: 25; height: 25
                source: "HomeIcon.png"
                anchors.left: parent.left
                anchors.leftMargin: 44
                anchors.verticalCenter: parent.verticalCenter
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        page.parent.replace("page_MainMenu.qml")
                    }
                }
            }

            Label {

                id: theDateTimeLabel
                text: qsTr("text")
                anchors.right: parent.right
                anchors.rightMargin: 44
                font.pointSize: 18
                anchors.verticalCenter: parent.verticalCenter
                color: "black"

                Timer{
                    interval: 500
                    running: true
                    repeat: true

                    onTriggered: {
                        var date = new Date()
                        var theString = String(date.toLocaleDateString(Qt.locale("en_BE"), "ddd dd-MM-yyyy")) + "  " +String(date.toLocaleTimeString(Qt.locale("be_BE"), "HH:mm"))
                        theDateTimeLabel.text = theString.replace(",", " ")
                    }
                }
            }
        }
    }

    ListModel{
        id:model

        ListElement{
            date:"02 March 2020 17:21"
            room:"Room 01"
            sensor:"Humidity"
            data:"12%"
        }
    }

    TableView{
        id:table
        width: parent.width-150
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: pageTitle.bottom
        anchors.topMargin: 50
        height: (parent.height/1.333)-50-refreshButton.height
        model:page.parent.alertsModel

        TableViewColumn{
            role:"date"
            title:"Date"
            width: table.width/4
            horizontalAlignment: Text.AlignHCenter
        }
        TableViewColumn{
            role:"room"
            title:"Room"
            width: table.width/4
            horizontalAlignment: Text.AlignHCenter
        }
        TableViewColumn{
            role:"sensor"
            title:"Sensor"
            width: table.width/4
            horizontalAlignment: Text.AlignHCenter
        }
        TableViewColumn{
            role:"data"
            title:"Data"
            width: table.width/4
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Rectangle {
        id: refreshButton
        width: 80
        height: 36
        color: "#55BCC9"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: name
            width: 76
            height: 28
            text: qsTr("Clear")
            font.pointSize: 24
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
        }
        MouseArea{
            anchors.fill:parent
            onClicked: {
                page.parent.alertsModel.clear()
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:800;width:1280}
}
##^##*/
