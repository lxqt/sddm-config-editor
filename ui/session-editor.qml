import QtQuick 2.2
import QtQuick.Layouts 1.1

Loader {
  Layout.fillWidth: true
  source: 'enum-editor.qml'
  Component.onCompleted: {
    var files = [];
    ["X11", "Wayland"].forEach(function(sectionName) {
      configEditor.directoryEntries(
        configEditor.getValue(sectionName, "SessionDir")
      ).forEach(function(file) {
        files.push(file);
      });
    });
    item.choices = files;
  }
}

