import QtQuick 2.2
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

GroupBox {
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
