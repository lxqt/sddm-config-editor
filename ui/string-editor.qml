import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1

RowLayout {
  property TextField textField: textField
  function textForValue() {
    return modelData.value;
  }
  Label {
    text: modelData.label
  }
  TextField {
    id: textField
    placeholderText: modelData.defaultValue
    Layout.fillWidth: true
  }
  Binding {
    target: modelData
    property: 'value'
    value: textField.text
  }
  Connections {
    target: configEditor
    onConfigurationChanged: textField.text = textForValue()
  }
}

