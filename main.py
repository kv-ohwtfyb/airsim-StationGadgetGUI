from PyQt5.QtQml import QQmlApplicationEngine, QJSValue
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

        #The password of the current user
        self.userPassword = None
        #Contains the initial JSON file sent by the server
        self.initialJSON = None
        #True if the user was granted access to the user, else False
        self.initiated = False
        #This variabe contains the status of the connection to the database
        self.statusVariable = ""

        sio.on("connect", self.connect)
        sio.on("disconnect", self.disconnect)
        sio.on("data", self.receivingData)
        sio.on("initial", self.receivingInitial)

    signalToQML_Strings = pyqtSignal(str, arguments=["statusFunction"])
    signalToQML_Initial = pyqtSignal(str, arguments = ["initialFunction"])

    @pyqtSlot()
    def initialFunction(self):
        """
        Emits the initial json file in a string format to QML.
        :return:
        """
        self.signalToQML_Initial.emit(self.initialJSON)

    @pyqtSlot(str)
    def statusFunction(self):
        """
        Emits the status of the connection to the server to QML
        """
        self.signalToQML_Strings.emit(self.statusVariable)

    @pyqtSlot(str)
    def start(self, password):
        """
        Connects to the server.
        """
        try:
            self.userPassword = password
            sio.connect("https://airsim.herokuapp.com")
        except Exception as e:
            print(f"{type(e)}, {e}")
            print("Error connecting to the server")


    def join(self):
        """
        When asking to join a room in the server
        :return: None.
        """
        sio.emit("join", {"password": f"{self.userPassword}", "room":"Kitchen"})
        self.signalToQML_Strings.emit("Sending the join request")
        self.statusVariable = "Sending the join request"


    @sio.on("connect")
    def connect(self):
        """
        When Connected.
        :return: None.
        """
        try:
            print("Connected")
            self.signalToQML_Strings.emit("Connected to the server")
            self.statusVariable = "Connected to the server"
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
            self.signalToQML_Strings.emit("Connection lost")
            self.statusVariable = "Connection lost"
        else:
            self.signalToQML_Strings.emit("Request denied by the server")
            self.statusVariable = "Request denied by the server"


    @sio.on("initial")
    def receivingInitial(self,data):
        """
        Receiving initial data from the server.
        :param data: JSON file sent by the server.
        :return: None.
        """
        try:
            self.initialJSON = json.dumps(data)
            self.initiated = True
            print(json.dumps(data, indent=2))
            self.signalToQML_Strings.emit("Received initial files")
            self.signalToQML_Initial.emit(self.initialJSON)
            self.statusVariable = "Received initial files"
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
