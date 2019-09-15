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
      item.choices = configEditor.directoryEntries(configEditor.getValue("Theme", "ThemeDir"));
    }
  }
  Button {
    iconName: 'view-preview'
    text: qsTr('Preview')
    onClicked: {
      closePreviewWindow.visible = true
      previewProcesses.push(configEditor.spawnProcess(
        'sddm-greeter --test-mode --theme ' + configEditor.absolutePath(configEditor.getValue("Theme", "ThemeDir"), effectiveTheme)
      ));
    }
  }
  ApplicationWindow {
    id: closePreviewWindow
    title: qsTr('Theme Preview')
    flags: Qt.WindowStaysOnTopHint | Qt.FramelessWindowHint
    width: 350
    height: 60

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

      ColumnLayout {
        anchors { left: parent.left; right: parent.right; margins: 10 }
        Label {
          text: qsTr('Displaying preview for SDDM theme <b>%1</b>...').arg(effectiveTheme)
          Layout.fillWidth: true
        }
        Button {
          Layout.fillWidth: true
          iconName: 'window-close'
          text: qsTr('Close Preview')
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
}

