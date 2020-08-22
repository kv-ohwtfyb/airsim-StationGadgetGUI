import QtQuick 2.2
import QtQuick.Controls 2.14
import QtQuick.Window 2.2

ApplicationWindow {
    id: window
    width: 1280
    height: 800
    visible: true
    title: qsTr("AirSim")
    maximumHeight: 800
    maximumWidth: 1280
    minimumHeight: 800
    minimumWidth: 1280
    StackView {

        //Functions

        property string user: "None"
        id: stackView
        initialItem: "page_Login.qml"
        anchors.fill: parent
    }
}

