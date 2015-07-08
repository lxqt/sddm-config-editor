import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3

import SDDMConfigurationEditor 0.1

ApplicationWindow {
  title: qsTr('SDDM Configuration Editor')
  visible: true
  property int columns: 3
  Component.onCompleted: configEditor.load()

  function layout(sections, columns) {
    columns = Math.min(columns, sections.length);
    // Sort sections by setting count descending
    var sectionsWithMostSettings = sections.sort(function(section1, section2) {
      return section2.settings.length - section1.settings.length;
    });
    var columnElements = sectionsWithMostSettings.slice(0, columns).map(function(section) {
      return [section];
    });
    sectionsWithMostSettings.slice(columns).forEach(function(section, index) {
      columnElements[index % columns].push(section);
    });
    return columnElements;
  }

  property variant columnItems: layout(configEditor.model, columns)

  RowLayout {
    anchors.margins: 10
    anchors.fill: parent
    spacing: 10

    Repeater {
      id: settingColumns
      model: columnItems.slice(0, columns - 1)

      ColumnLayout {
        spacing: 10

        Repeater {
          model: modelData

          Loader {
            Layout.fillWidth: true
            Layout.fillHeight: true
            source: 'setting-section.qml'
          }
        }
      }
    }

    ColumnLayout {
      spacing: 10

      Repeater {
        model: columnItems[columns - 1]

        Loader {
          Layout.fillWidth: true
          Layout.fillHeight: true
          source: 'setting-section.qml'
        }
      }

      ColumnLayout {
        Layout.fillHeight: true
        Label {
          text: qsTr('Configuration file')
          Layout.alignment: Qt.AlignCenter
        }
        TextArea {
          id: configTextArea
          text: configEditor.config_text
          readOnly: true
          Layout.fillWidth: true
          Layout.fillHeight: true
        }
        RowLayout {
          Layout.alignment: Qt.AlignRight
          Button {
            Layout.fillWidth: true
            iconName: 'document-revert'
            text: qsTr('Load')
            onClicked: configEditor.load()
            tooltip: 'Load the configuation file on the system into the text area and update the displayed settins'
          }
          Button {
            Layout.fillWidth: true
            iconName: 'run-build-install-root'
            text: qsTr('Save...')
            onClicked: configEditor.save()
            tooltip: qsTr('Save the configuration file in the text area to the system')
          }
        }
      }
    }
  }
  ConfigEditorController {
    id: configEditor
  }
}
