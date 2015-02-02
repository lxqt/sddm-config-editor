import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1
import QtQuick.Dialogs 1.2

RowLayout {
  Loader {
    source: 'string-editor.qml'
    Layout.fillWidth: true
  }
  Button {
    iconName: type == 'directory' ? 'folder' : 'application-x-executable'
    Layout.alignment: Qt.AlignRight
    onClicked: {
      fileDialog.open()
    }
  }

  FileDialog {
    id: fileDialog
    title: "Please choose a " + type
    folder: default_value || '/'
    selectFolder: type == 'directory'
    onAccepted: {
      console.log("You chose: " + fileDialog.fileUrls)
    }
    onRejected: {
      console.log("Canceled")
    }
  }
}
