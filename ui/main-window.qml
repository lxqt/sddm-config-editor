import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3

import SDDMConfigEditor 0.1

ApplicationWindow {
  title: 'SDDM Configuration Editor'
  visible: true

  GridLayout {
    rows: 2
    flow: GridLayout.TopToBottom

    Repeater {
      model: configEditor.model
      delegate: GroupBox {
        Layout.fillHeight: true
        Layout.fillWidth: true

        title: section

        ColumnLayout {
          spacing: 10

          Repeater {
            Layout.fillWidth: true
            model: entries

            delegate: ColumnLayout {
              Loader {
                source: type + '-editor.qml'
                Layout.fillWidth: true
              }

              Text {
                font.italic: true
                text: description
                visible: description.length > 0
              }
            }
          }
        }
      }
    }

    GroupBox {
      title: 'Configuration file'
      Layout.fillWidth: true
      Layout.fillHeight: true

      TextArea {
        text: ''
        anchors.fill: parent
      }
    }
  }
  ConfigEditorController {
    id: configEditor
  }
}
