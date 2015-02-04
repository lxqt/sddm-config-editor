import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1
import QtQuick.Dialogs 1.2

RowLayout {
  Loader {
    id: loader
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
    folder: 'file://' + (modelData.default_value || '/')
    selectFolder: modelData.type == 'directory'
    onAccepted: {
      loader.item.textField.text = fileDialog.fileUrl.toString().replace(/^file:\/\//, '')
    }
  }
}
