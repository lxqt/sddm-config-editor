import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1

Loader {
  Layout.fillWidth: true
  source: 'enum-editor.qml'
  Component.onCompleted: {
    item.choices = configEditor.subDirectories("/usr/share/sddm/themes");
  }
}

