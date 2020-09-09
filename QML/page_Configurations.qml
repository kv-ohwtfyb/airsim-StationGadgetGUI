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
        // This wraps how the Component that will be seen in the ListView.
        id:customDelegate

        Rectangle {
            id: wrapItem
            width:parent.width-80
            height: 80
            color: "#55BCC9"
            anchors.horizontalCenter: parent.horizontalCenter

            property var theStation: stationId
            property var theSensorTitle: sensorTitle
            property var actualFirst: theSlider.actualFirstValue
            property var actualSecond: theSlider.actualSecondValue

            Text {
                id: sensorName
                text: sensorTitle
                width:180
                anchors.left: parent.left
                anchors.leftMargin: 16
                font.pointSize: 16
                anchors.verticalCenter: parent.verticalCenter
            }

            Item {
                id: doubleSliderWrapper
                width: parent.width-sensorName.width
                height: parent.height
                anchors.right: parent.right

                RectangleDoubleSlider{
                    id:theSlider
                    anchors.fill:parent
                    anchors.top:parent.top
                    anchors.topMargin: 10
                    secondValue:(1/(captiveMaximum - captiveMinimum))*cautionMaximum
                    firstValue:(1/(captiveMaximum - captiveMinimum))*cautionMinimum
                    max:captiveMaximum
                    min:captiveMinimum
                    stationIdName: stationId
                }
            }
        }
    }

    ScrollView {

        anchors.top: pageTitle.bottom
        anchors.topMargin: 50
        width: parent.width; height: parent.height-pageTitle.height-90-saveButton.height

        ListView {
            id:configurationListView
            model: page.parent.sensorModel
            width: parent.width;
            delegate: customDelegate
            spacing: 20
        }
    }

    Rectangle {
        id: saveButton
        width: 80
        height: 36
        color: "#55BCC9"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 25
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
            onClicked: {
                    for(var i = 0; i < configurationListView.count; ++i){
                        const element = configurationListView.itemAtIndex(i)
                        if(element){
                            const index = page.parent.findTheElement(element.theSensorTitle,element.theStation)
                            page.parent.sensorModel.setProperty(index,"cautionMinimum",String(element.actualFirst))
                            page.parent.sensorModel.setProperty(index,"cautionMaximum",String(element.actualSecond))
                    }
                }
                    page.parent.replace("page_DataDisplay.qml")
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
