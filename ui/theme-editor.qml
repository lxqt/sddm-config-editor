import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1
import QtQuick.Window 2.2

RowLayout {
  property var previewProcesses: []
  property var effectiveTheme: modelData.value || modelData.defaultValue
  Loader {
    Layout.fillWidth: true
    source: 'enum-editor.qml'
    Component.onCompleted: {
      item.choices = configEditor.subDirectories("/usr/share/sddm/themes");
    }
  }
  Button {
    iconName: 'view-preview'
    onClicked: {
      closePreviewWindow.visible = true
      previewProcesses.push(configEditor.spawnProcess(
        'sddm-greeter --test-mode --theme /usr/share/sddm/themes/' + effectiveTheme
      ));
    }
  }
  ApplicationWindow {
    id: closePreviewWindow
    title: 'Theme Preview'
    flags: Qt.WindowStaysOnTopHint | Qt.FramelessWindowHint

    ColumnLayout {
      anchors.margins: 10
      anchors.fill: parent
      MouseArea {
        anchors.fill: parent
        property real lastMouseX: 0
        property real lastMouseY: 0
        cursorShape: pressed ? Qt.DragMoveCursor : Qt.OpenHandCursor
        onPressed: {
          lastMouseX = mouseX
          lastMouseY = mouseY
        }
        onMouseXChanged: closePreviewWindow.x += (mouseX - lastMouseX)
        onMouseYChanged: closePreviewWindow.y += (mouseY - lastMouseY)
      }
      Label {
        text: 'Displaying preview for SDDM theme <b>' + effectiveTheme + '</b>...'
      }
      Button {
        Layout.fillWidth: true
        iconName: 'window-close'
        text: 'Close Preview'
        onClicked: {
          previewProcesses.forEach(function(process) {
            configEditor.closeProcess(process);
          });
          closePreviewWindow.visible = false;
        }
      }
    }
  }
}

