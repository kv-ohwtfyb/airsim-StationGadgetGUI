import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3
import QtQml 2.0

Page{
    id : page

    //Properties
    property var initialJSON: null
    property string pageName: "page_DataDisplay"
    property alias theRepeater: theRepeater


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
            columns: 1
            spacing: 20

            Repeater{
                id:theRepeater
                model: page.parent.sensorModel
                delegate: RectangleDisplay{
                    value:customNumber
                    title:sensorTitle
                    captiveMax: captiveMaximum
                    captiveMin: captiveMinimum
                    cautionMax: cautionMaximum
                    cautionMin: cautionMinimum
                    station: stationId
                    unit:SensorUnit
                }
            }
        }
    }

    Component.onCompleted: {
        if (page.parent.initialJSON){
            const initialJSON = page.parent.initialJSON
            roomTitle.text=initialJSON.id
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
