import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3
import QtQml 2.0

Page{
    id : page

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
                id:text1
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
            customNumber:12
            captiveMinimum:-1
            captiveMaximum:100
            cautionMinimum:35
            cautionMaximum:70
        }
        ListElement{
            customNumber:-1
            captiveMinimum:-100
            captiveMaximum:100
            cautionMinimum:0
            cautionMaximum:70
        }
        ListElement{
            customNumber:30
            captiveMinimum:00
            captiveMaximum:80
            cautionMinimum:20
            cautionMaximum:40
        }
        ListElement{
            customNumber:0.2
            captiveMinimum:0.57
            captiveMaximum:0.89
            cautionMinimum:0
            cautionMaximum:0.4
        }
        ListElement{
            customNumber:23
            captiveMinimum:-100
            captiveMaximum:100
            cautionMinimum:0
            cautionMaximum:70
        }
    }

    Flickable{
        anchors.top: pageTitle.bottom
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        height: parent.height-pageTitle.height-100
        width: parent.width

        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.DragOverBounds
        clip: true
        contentHeight: theWidgetsGridView.height

        Grid{
            id:theWidgetsGridView
            anchors.horizontalCenter: parent.horizontalCenter
            columns: 2
            spacing: 20

            Repeater{
                model: model
                delegate: RectangleDisplay{
                    id:rectDisp
                    value:customNumber
                    captiveMax: captiveMaximum
                    captiveMin: captiveMinimum
                    cautionMax: cautionMaximum
                    cautionMin: cautionMinimum
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
