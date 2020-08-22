import QtQuick 2.14

Item {
    property alias theWidth: innerRectangle.theWidth
    property alias theHeight: innerRectangle.theHeight
    property alias theTitle: innerRectangle.theTitle
    property alias theValue: innerRectangle.theValue
    property alias theColor: innerRectangle.theColor

    Rectangle {
        id:innerRectangle
        property int theWidth: 128
        property int theHeight: 162
        property string theTitle: qsTr("Humidity")
        property var theValue: qsTr("89")
        property var theColor: "red"

        width: theWidth; height: theHeight
        color: theColor

        Column {
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                text: innerRectangle.theTitle
                font.pointSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: innerRectangle.theValue
                font.pointSize: 80
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
