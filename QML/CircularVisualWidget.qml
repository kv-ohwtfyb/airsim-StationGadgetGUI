import QtQuick 2.14
import QtQuick.Controls 2.5
import QtQuick.Shapes 1.14


Item {
    visible: true

    property alias min: wholeRing.min
    property alias max: wholeRing.max
    property alias value: wholeRing.currentValue
    property alias ringColor: path.strokeColor
    property alias pointColor: theCirclePoint.color
    property alias theWidth: wholeRing.width
    property alias unit: wholeRing.unit


    Rectangle {

        id:wholeRing
        width: 420
        height: width
        color: "#00000000"
        border.width:25
        border.color: "grey"
        radius: width*0.5

        property int min: 0
        property int max: 100
        property int currentValue: 0
        property int name: value
        property string unit: qsTr("°C")

        onCurrentValueChanged: {
            resetPosition(currentValue)
        }

        // Functions

        function resetPosition(value){
            // This Function reestablish the position of the innerCirclePoint
            element.rotation=360*value/(wholeRing.max-wholeRing.min)
        }

        Text {
            id: valueText
            text: wholeRing.currentValue + wholeRing.unit
            font.bold: true
            font.pointSize: wholeRing.width/3.5
            font.family: "Verdana"
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                wholeRing.currentValue++
            }
        }

        Shape {
            width: parent.width
            height: parent.height
            anchors.fill: parent

            layer.enabled: true
            layer.samples: 4

            ShapePath {
                id:path
                fillColor: "transparent"
                strokeColor: "#a20303"
                strokeWidth: wholeRing.border.width
                //capStyle: ShapePath.FlatCap

                PathAngleArc {
                    centerX: wholeRing.width/2; centerY: wholeRing.width/2
                    radiusX: wholeRing.radius-12.5; radiusY: radiusX
                    startAngle: -90
                    sweepAngle: element.rotation - theCirclePoint.radius/8
                }
            }
        }

        Item {
            id: element
            anchors.fill: parent
            width: parent.width
            height: width
            rotation: 0

            Rectangle {
                id:theCirclePoint
                y:-width/8
                anchors.horizontalCenter: parent.horizontalCenter
                width: wholeRing.width/10
                height: width

                color: "#4747f3"
                radius: width*0.5
                rotation: 0
            }
        }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
