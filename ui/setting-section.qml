import QtQuick 2.2
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

GroupBox {
  title: modelData.name

  ColumnLayout {
    spacing: 10
    anchors.fill: parent
    anchors.margins: 5

    Repeater {
      Layout.fillWidth: true
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
          text: modelData.description
          visible: modelData.description.length > 0
        }
      }
    }
  }
}
