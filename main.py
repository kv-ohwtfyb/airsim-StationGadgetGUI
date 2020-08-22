from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtWidgets import QApplication
import sys

def runQML():
    """
    This function runs the App.
    :return:
    """
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.load('./QML/main.qml')

    if not engine.rootObjects():
        return -1
    return app.exec_()

if __name__ == "__main__":
    sys.exit(runQML())