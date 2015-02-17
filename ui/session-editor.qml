import QtQuick 2.2
import QtQuick.Layouts 1.1

Loader {
  Layout.fillWidth: true
  source: 'enum-editor.qml'
  Component.onCompleted: {
    item.choices = configEditor.directoryEntries("/usr/share/xsessions").map(function(name) {
      return name.replace(/\.desktop$/, '');
    });
  }
}

