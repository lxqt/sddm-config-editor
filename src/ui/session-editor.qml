import QtQuick 2.2
import QtQuick.Layouts 1.1

Loader {
  Layout.fillWidth: true
  source: 'enum-editor.qml'
  Component.onCompleted: {
    var files = [];
    ["X11", "Wayland"].forEach(function(sectionName) {
      var directory = configEditor.getValue(sectionName, "SessionDir");
      configEditor.directoryEntries(directory).forEach(function(file) {
        files.push(configEditor.absolutePath(directory, file));
      });
    });
    item.choices = files;
  }
}

