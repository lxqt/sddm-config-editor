import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3

import 'ubuntu-ui-extras'
import SDDMConfigurationEditor 0.1

ApplicationWindow {
  title: 'SDDM Configuration Editor'
  visible: true
  width: 1200
  height: 700

  RowLayout {
    anchors.fill: parent
    ColumnFlow {
      columns: 2
      Layout.fillWidth: true
      Layout.fillHeight: true
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
      Layout.fillHeight: true

      ColumnLayout {
        anchors.fill: parent
        TextArea {
          id: configTextArea
          text: configEditor.config_text
          Layout.fillWidth: true
          Layout.fillHeight: true
        }
        RowLayout {
          Layout.alignment: Qt.AlignRight
          Button {
            iconName: 'applications-system'
            text: 'Parse'
            onClicked: configEditor.parse(configTextArea.text)
            tooltip: 'Parse the configuration in the text area and update the displayed settings'
          }
          Button {
            iconName: 'text-x-generic'
            text: 'Generate'
            onClicked: configEditor.generate()
            tooltip: 'Generate a configuration file from the settings and put it in the text area'
          }
          Button {
            iconName: 'document-revert'
            text: 'Load'
            onClicked: configEditor.load()
            tooltip: 'Load the configuation file on the system into the text area and update the displayed settins'
          }
          Button {
            iconName: 'run-build-install-root'
            text: 'Save...'
            onClicked: configEditor.save()
            tooltip: 'Save the configuration file in the text area to the system'
          }
        }
      }
    }
  }
  ConfigEditorController {
    id: configEditor
  }
}
