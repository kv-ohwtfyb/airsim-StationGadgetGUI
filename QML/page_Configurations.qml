import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3

Page{
    id: page

    //Properties
    property string pageName: "page_Configurations"

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

    Component{
        // This wraps how the data will be seen in the ListView.
        id:customDelegate

        Rectangle {
            id: wrapItem
            width:parent.width-80
            height: 135
            color: "#55BCC9"
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                id: sensorName
                text: sensor
                anchors.left: parent.left
                anchors.leftMargin: 16
                font.pointSize: 30
                anchors.verticalCenter: parent.verticalCenter
            }

            Item {
                id: doubleSliderWrapper
                width: 800
                height: parent.height
                anchors.right: parent.right

                RectangleDoubleSlider{
                    y:30
                }
            }
        }
    }

    ListModel{
        // THis is kinda like a DB, but not actually
        id:model
        ListElement{
            sensor:"Room Temperature"
        }
        ListElement{
            sensor:"Room Humidity"
        }
        ListElement{
            sensor:"Room Oxygen"
        }
    }

    ScrollView {

        anchors.top: pageTitle.bottom
        anchors.topMargin: 50
        width: parent.width; height: parent.height-pageTitle.height-90-saveButton.height

        ListView {

            model: model
            width: parent.width-40;
            spacing: 20

            delegate: customDelegate
        }
    }

    Rectangle {
        id: saveButton
        width: 80
        height: 36
        color: "#55BCC9"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: name
            anchors.fill: parent
            text: qsTr("Save")
            font.pointSize: 24
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
        }
        MouseArea{
            anchors.fill:parent
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
