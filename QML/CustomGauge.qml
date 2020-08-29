import QtQuick 2.14
import QtQuick.Controls 2.5
import QtQuick.Shapes 1.14

Shape {

    property int value: 23
    property int captiveMax: 100
    property int captiveMin: -100
    property int cautionMax: 70
    property int cautionMin: 0

    id:shape
    width: 200
    height: width

    layer.enabled: true
    layer.samples: 4

    ShapePath {
        id:theMainPath
        fillColor: "transparent"
        strokeColor: "#CAFAFE"
        strokeWidth: shape.width/10
        capStyle: ShapePath.RoundCap

        PathAngleArc {
            id:theMainPathArcItem
            centerX: shape.width/2; centerY: shape.width/2
            radiusX: shape.width/2-theMainPath.strokeWidth; radiusY: radiusX
            startAngle: -225
            sweepAngle: 270
        }
    }

    ShapePath {
        id:theYellow1Path
        fillColor: "transparent"
        strokeColor: "#FFC400"
        strokeWidth: shape.width/14
        capStyle: ShapePath.RoundCap

        PathAngleArc {
            id:theYellow1PathArcItem
            centerX: shape.width/2; centerY: shape.width/2
            radiusX: shape.width/2-theMainPath.strokeWidth; radiusY: radiusX
            startAngle: -225
            sweepAngle: (cautionMin - captiveMin) * (270/(captiveMax-captiveMin))
        }
    }

    ShapePath {
        id:theGreenPath
        fillColor: "transparent"
        strokeColor: "#00FF4E"
        strokeWidth: shape.width/14
        capStyle: ShapePath.RoundCap

        PathAngleArc {
            id:theGreenPathArcItem
            centerX: shape.width/2; centerY: shape.width/2
            radiusX: shape.width/2-theMainPath.strokeWidth; radiusY: radiusX
            startAngle: theYellow1PathArcItem.startAngle + theYellow1PathArcItem.sweepAngle
            sweepAngle: (cautionMax - cautionMin) * (270 / (captiveMax-captiveMin))
        }
    }


    ShapePath {
        id:theYellow2Path
        fillColor: "transparent"
        strokeColor: "#FFC400"
        strokeWidth: shape.width/14
        capStyle: ShapePath.RoundCap

        PathAngleArc {
            id:theYellow2PathArcItem
            centerX: shape.width/2; centerY: shape.width/2
            radiusX: shape.width/2-theMainPath.strokeWidth; radiusY: radiusX
            startAngle: theGreenPathArcItem.startAngle + theGreenPathArcItem.sweepAngle
            sweepAngle: (captiveMax - cautionMax) * (270 / (captiveMax-captiveMin))
        }
    }


    Text {
        id: element
        text: value
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.bold: true
        font.pixelSize: parent.width/2.5
    }

    Item {
        id: itemRound
        anchors.fill: parent
        rotation: 225 + ((value-captiveMin) * (270 / (captiveMax-captiveMin)))

        Rectangle{
            y: width*(2.5/4)
            width: shape.width/11
            height: width
            radius: width/2
            anchors.horizontalCenter: parent.horizontalCenter
            color: "black"
        }
    }
}
