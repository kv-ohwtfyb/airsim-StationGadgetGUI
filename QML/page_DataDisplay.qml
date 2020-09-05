import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3
import QtQml 2.0

Page{
    id : page

    //Properties
    property var initialJSON: null

    //Functions

    function findTheElement(sensorId, stationId){
        for(var i = 0; i < sensorModel.count; ++i){
                if (sensorModel.get(i).sensorTitle===sensorId && sensorModel.get(i).stationId){
                    return i
                }
            }
        return null
    }


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
        id:sensorModel
        /*
        ListElement{
            sensorTitle:"Temperature"
            customNumber:12
            captiveMinimum:-1
            captiveMaximum:100
            cautionMinimum:35
            cautionMaximum:70
            stationId:"StationId"
        } */
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
                id:theRepeater
                model: sensorModel
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

    Connections{
        target: socketFromPython

        onSignalToQML_Initial:{
            //When initiating a connection.
            page.initialJSON = JSON.parse(initialFunction)
            roomTitle.text = page.initialJSON.id
            sensorModel.clear()
            page.initialJSON.stations.forEach(function(station){
                station.sensors.forEach(function(sensor){
                    sensorModel.append({"sensorTitle": sensor.id,
                                        "captiveMinimum": sensor["Captive Range"].split("-")[0],
                                        "captiveMaximum": sensor["Captive Range"].split("-")[1],
                                        "cautionMinimum": sensor["Caution Range"].split("-")[0],
                                        "cautionMaximum": sensor["Caution Range"].split("-")[1],
                                        "stationId":station.id,
                                        "SensorUnit":sensor.Unit,
                                        "customNumber": parseFloat(sensor["Captive Range"].split("-")[0])
                                       })
                })
            })
        }

        onSignalToQML_Data:{
            //When updating data from station.
            const data = JSON.parse(dataFecthFunction);
            if (data.room===roomTitle.text){
                data.sensors.forEach(function(sensor){
                    const elementNumber = findTheElement(sensor.id, data.stationId)
                    if (elementNumber !== null){
                        theRepeater.itemAt(elementNumber).value = sensor.data
                        //Alerts managing
                        const date = new Date()
                        if (sensor.data<=parseFloat(theRepeater.itemAt(elementNumber).cautionMin)||sensor.data>=parseFloat(theRepeater.itemAt(elementNumber).cautionMax)){
                            page.parent.alertsModel.append({"date":String(date.toLocaleDateString(Qt.locale("en_BE"), "dd-MM-yyyy")),
                                                            "time":String(date.toLocaleTimeString(Qt.locale("be_BE"), "HH:mm")),
                                                            "sensor":sensor.id,
                                                            "data":String(sensor.data),
                                                            "room":data.room
                            })
                        }
                    }
                })
            }
        }
    }
    Component.onCompleted: {
        socketFromPython.initialFunction()
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
