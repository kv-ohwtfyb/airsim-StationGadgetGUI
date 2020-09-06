import QtQuick 2.2
import QtQuick.Controls 2.14
import QtQuick.Window 2.2

ApplicationWindow {
    id: window
    width: 800
    height: 480
    visible: true
    title: qsTr("AirSim")
    minimumHeight: 800
    minimumWidth: 480
    //visibility : "FullScreen"

    //Functions
    function findTheElement(sensorId, stationId){
        for(var i = 0; i < mainStackView.sensorModel.count; ++i){
                if (mainStackView.sensorModel.get(i).sensorTitle===sensorId && mainStackView.sensorModel.get(i).stationId){
                    return i
                }
            }
        return null
    }


    StackView {
        id: mainStackView

        //Propreties
        property ListModel alertsModel: ListModel{}
        property ListModel sensorModel: ListModel{}
        property var initialJSON: null

        initialItem: "page_Login.qml"
        anchors.fill: parent
    }


    Connections{
        target: socketFromPython

        onSignalToQML_Initial:{
            //When initiating a connection.
            mainStackView.initialJSON = JSON.parse(initialFunction)
            mainStackView.sensorModel.clear()
            mainStackView.initialJSON.stations.forEach(function(station){
                station.sensors.forEach(function(sensor){
                    mainStackView.sensorModel.append({"sensorTitle": sensor.id,
                                        "captiveMinimum": sensor["Captive Range"].split("-")[0],
                                        "captiveMaximum": sensor["Captive Range"].split("-")[1],
                                        "cautionMinimum": sensor["Caution Range"].split("-")[0],
                                        "cautionMaximum": sensor["Caution Range"].split("-")[1],
                                        "stationId":station.id,
                                        "SensorUnit":sensor.Unit,
                                        "customNumber": parseFloat(sensor["Captive Range"].split("-")[0]),
                                        "lastTime":"Undefined"
                    })
                })
            })
        }

        onSignalToQML_Data:{
            //When updating data from station.
            const data = JSON.parse(dataFecthFunction);
            if (data.room===mainStackView.initialJSON.id){
                data.sensors.forEach(function(sensor){
                    const elementNumber = findTheElement(sensor.id, data.stationId)

                    //If the sensor exists
                    if (elementNumber !== null){
                        const date = new Date()
                        //Updates the value in the sensorModel
                        mainStackView.sensorModel.setProperty(elementNumber,"customNumber",sensor.data)
                        mainStackView.sensorModel.setProperty(elementNumber,"lastTime",String(date.toLocaleTimeString(Qt.locale("be_BE"), "HH:mm")))

                        //Alerts managing
                        if (sensor.data<=parseFloat(mainStackView.sensorModel.get(elementNumber).cautionMinimum)||sensor.data>=parseFloat(mainStackView.sensorModel.get(elementNumber).cautionMaximum)){

                            mainStackView.alertsModel.append({"date":String(date.toLocaleDateString(Qt.locale("en_BE"), "dd-MM-yyyy")),
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
