import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1

RowLayout {
  Label {
    text: modelData.label
  }
  TextField {
    placeholderText: modelData.default_value
    text: modelData.isDefined() ? modelData.value : ''
    Layout.fillWidth: true
    onEditingFinished: modelData.value = text
  }
}

