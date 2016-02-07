import QtQuick 2.2
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

ColumnLayout {
  spacing: 10
  anchors.margins: 10
  anchors.fill: parent

  Repeater {
    model: modelData.settings

    delegate: ColumnLayout {
      spacing: 5
      Loader {
        source: modelData.type + '-editor.qml'
        Layout.fillWidth: true
      }

      Text {
        anchors.leftMargin: 10
        anchors.left: parent.left
        text: qsTranslate('config-strings', modelData.description)
        visible: modelData.description.length > 0
      }
    }
  }

  // flexible space
  Rectangle {
    Layout.fillHeight: true
  }

  Component.onCompleted: {
    configEditor.refreshView()
  }
}

