from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtWidgets import QApplication
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot, QVariant
import sys
import socketio
import json

sio = socketio.Client()

class Socket(QObject):
    """docstring for ."""

    def __init__(self, socket):
        """
        Initiator.
        :param socket : A socketio client object.
        """
        QObject.__init__(self)
        self.userPassword = None
        self.initial = None
        self.update = None
        self.initiated = False

        sio.on("connect", self.connect)
        sio.on("disconnect", self.disconnect)
        sio.on("data", self.receivingData)
        sio.on("initial", self.receivingInitial)

    SignalToQML = pyqtSignal(str, arguments=["start"])

    @pyqtSlot(str)
    def start(self, password):
        """
        Connects to the server.
        """
        try:
            self.userPassword = password
            print(self.userPassword)
            sio.connect("https://airsim.herokuapp.com")
        except Exception as e:
            sio.disconnect()
            print(f"{type(e)}, {e}")
            print("Error connecting to the server")


    def join(self):
        """
        When asking to join a room in the server
        :return: None.
        """
        sio.emit("join", {"password": f"{self.userPassword}"})


    @sio.on("connect")
    def connect(self):
        """
        When Connected.
        :return: None.
        """
        try:
            print("Connected")
            self.join()
        except Exception as e:
            print(e)
            print("Error while connecting to the server")


    @sio.on("disconnect")
    def disconnect(self):
        """
        This function is when the socket gets disconnected
        :return: None.
        """
        print("Disconnected")
        if self.initiated:
            self.SignalToQML.emit("Connection lost")
        else:
            self.SignalToQML.emit("Request denied by the server")



    @sio.on("initial")
    def receivingInitial(self,data):
        """
        Receiving initial data from the server.
        :param data: JSON file sent by the server.
        :return: None.
        """
        try:
            self.initial = data
            self.initiated = True
            print(json.dumps(data, indent=2))
        except Exception as e:
            print("Error when initiating")
            print(e)


    @sio.on("data")
    def receivingData(self,data):
        """
        Receiving data from the server.
        :param data: JSON file sent by the server.
        :return: None.
        """
        print(json.dumps(data, indent=2))


def runQML(socket):
    """
    This function runs the App.
    :param socket : a QObject that will be connected to the server
    :return: an execution command.
    """
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty("socketFromPython", socket)
    engine.load('./QML/main.qml')
    engine.quit.connect(app.quit)

    if not engine.rootObjects():
        return -1
    return app.exec_()


if __name__ == "__main__":
    socket = Socket(sio)
    sys.exit(runQML(socket))
