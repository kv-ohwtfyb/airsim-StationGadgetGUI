import QtQuick 2.2
import QtQuick.Controls 2.14
import QtQuick.Window 2.2

ApplicationWindow {
    id: window
    width: 1280
    height: 800
    visible: true
    title: qsTr("AirSim")
    minimumHeight: 800
    minimumWidth: 1280
    //visibility : "FullScreen"``

    Connections{
        id:connect
        target: socketFromPython
    }

    StackView {

        property var socketFromPy: null
        id: stackView
        initialItem: "page_Login.qml"
        anchors.fill: parent
    }

    Component.onCompleted: {
        console.log(socketFromPython)
    }
}
