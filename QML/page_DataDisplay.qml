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
                source: "/new/prefix1/HomeIcon.png"
                anchors.left: parent.left
                anchors.leftMargin: 44
                anchors.verticalCenter: parent.verticalCenter
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        //page.parent.replace("qrc:/page_MainMenu.qml")
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
        // This is kinda like a DB, but not actually
        id:model
        ListElement{
            customNumber:12
        }
        ListElement{
            customNumber:-1
        }
        ListElement{
            customNumber:87
        }
        ListElement{
            customNumber:34
        }
        ListElement{
            customNumber:23
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
                }
            }
        }
    }

    Component.onCompleted: {
        console.log(page.parent.user)
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
