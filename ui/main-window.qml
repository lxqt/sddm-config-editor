import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3

import SDDMConfigurationEditor 0.1

ApplicationWindow {
  title: qsTr('SDDM Configuration Editor')
  visible: true
  Component.onCompleted: configEditor.load()

  width: 500
  height: 400

  ColumnLayout {
    anchors.margins: 5
    anchors.fill: parent

    TabView {
      Layout.fillWidth: true
      Layout.fillHeight: true
      Repeater {
        model: configEditor.model
        Tab {
          title: qsTr(modelData.name)
          source: 'setting-section.qml'
        }
      }
      Tab {
        title: qsTr('File')
        TextArea {
          id: configTextArea
          text: configEditor.config_text
          readOnly: true
          anchors.margins: 10
          anchors.fill: parent
        }
      }
    }

    RowLayout {
      Layout.alignment: Qt.AlignRight
      Button {
        iconName: 'document-revert'
        text: qsTr('Reset')
        onClicked: configEditor.load()
        tooltip: 'Load settings from the system configuation file'
      }
      Button {
        iconName: 'run-build-install-root'
        text: qsTr('Save...')
        onClicked: configEditor.save()
        tooltip: qsTr('Save the settings to the system configuration file')
      }
    }
  }

  ConfigEditorController {
    id: configEditor
  }
}
