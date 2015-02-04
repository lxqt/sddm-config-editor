import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3

import SDDMConfigurationEditor 0.1

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

        title: modelData.section

        ColumnLayout {
          spacing: 10
          anchors.left: parent.left
          anchors.right: parent.right

          Repeater {
            Layout.fillWidth: true
            model: modelData.settings

            delegate: ColumnLayout {
              Loader {
                source: modelData.type + '-editor.qml'
                Layout.fillWidth: true
              }

              Text {
                font.italic: true
                text: modelData.description
                visible: modelData.description.length > 0
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

      ColumnLayout {
        anchors.fill: parent
        TextArea {
          text: configEditor.config_text
          Layout.fillWidth: true
          Layout.fillHeight: true
        }
        RowLayout {
          Layout.alignment: Qt.AlignRight
          Button {
            iconName: 'text-x-generic'
            text: 'Generate'
            onClicked: configEditor.generate()
          }
          Button {
            iconName: 'document-revert'
            text: 'Load'
            onClicked: configEditor.load()
          }
          Button {
            iconName: 'run-build-install-root'
            text: 'Save...'
            onClicked: configEditor.save()
          }
        }
      }
    }
  }
  ConfigEditorController {
    id: configEditor
  }
}
