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
    iconName: modelData.type == 'directory' ? 'folder' : 'application-x-executable'
    Layout.alignment: Qt.AlignRight
    onClicked: {
      fileDialog.open()
    }
  }

  FileDialog {
    id: fileDialog
    title: "Please choose a " + modelData.type
    folder: modelData.default_value || '/'
    selectFolder: modelData.type == 'directory'
    onAccepted: {
      console.log("You chose: " + fileDialog.fileUrls)
    }
    onRejected: {
      console.log("Canceled")
    }
  }
}
