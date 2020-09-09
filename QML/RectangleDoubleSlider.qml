import QtQuick 2.14
import QtQuick.Controls 2.5
import QtQuick.Shapes 1.14
import QtQuick.Layouts 1.3

Item{
    property alias theWidth: theLayout.mWidth
    property alias theHeight: theLayout.mHeight
    property real firstValue: 0.25
    property real secondValue: 0.75
    property real max: 1
    property real min: 0
    property real actualFirstValue: (rangeSlider.first.value * (max-min)).toFixed(2)
    property real actualSecondValue: (rangeSlider.second.value * (max-min)).toFixed(2)
    property var stationIdName: "value"


    ColumnLayout {

        property int mWidth: 520
        property int mHeight: 30

        id:theLayout
        width: mWidth; height: mHeight
        spacing: 18

        Rectangle{
            width: parent.width-40
            height: parent.height/4
            Layout.alignment: Qt.AlignHCenter
            color: "#55BCC9"


            Rectangle{
                id:firstValueWrapRectangle
                width:height ; height:parent.height*4
                color: "transparent"
                x:rangeSlider.first.value*parent.width - firstValueWrapRectangle.width/2

                Rectangle{
                    id:firstValueRectangle
                    width: parent.width ; height:parent.height* (3.2/4)
                    color: "#3b3b3c"
                    anchors.horizontalCenter: parent.horizontalCenter
                    radius:width/10

                    Text {
                        id: firstValueRectangleText
                        color: "white"
                        text: String(rangeSlider.first.value * (max-min)).substring(0,4)
                        font.pointSize: parent.width/2
                        anchors.centerIn: parent
                    }
                }

                Canvas{
                    id:firstValueTriangle
                    width: parent.width; height: parent.height
                    onPaint: {
                        var context = getContext("2d")
                        context.beginPath();
                        context.moveTo(width/2, height);
                        context.lineTo(width/2+width/4, height-height/4);
                        context.lineTo(width/2-width/4, height-height/4);
                        context.closePath();

                        // the fill color
                        context.fillStyle = firstValueRectangle.color;
                        context.fill();
                    }
                }
            }

            Rectangle{
                id:secondValueWrapRectangle
                width:height ; height:parent.height*4
                color: "transparent"
                x:rangeSlider.second.value*parent.width - secondValueRectangle.width/2


                Rectangle{
                    id:secondValueRectangle
                    width: parent.width ; height:parent.height* (3.2/4)
                    color: "#3b3b3c"
                    anchors.horizontalCenter: parent.horizontalCenter
                    radius:width/10


                    Text {
                        id: secondValueRectangleText
                        color: "white"
                        text: String(rangeSlider.second.value * (max-min)).substring(0,4)
                        font.pointSize: parent.width/2
                        anchors.centerIn: parent
                    }
                }
                Canvas{
                    id:secondValueTriangle
                    width: parent.width; height: parent.height
                    onPaint: {
                        var context = getContext("2d")
                        context.beginPath();
                        context.moveTo(width/2, height);
                        context.lineTo(width/2+width/4, height-height/4);
                        context.lineTo(width/2-width/4, height-height/4);
                        context.closePath();

                        // the fill color
                        context.fillStyle = secondValueRectangle.color;
                        context.fill();
                    }
                }
            }
        }

        RangeSlider {
            id: rangeSlider
            width: parent.width
            second.value: secondValue
            first.value: firstValue
            Layout.fillWidth: true
            height: 10
        }
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:800}
}
##^##*/
