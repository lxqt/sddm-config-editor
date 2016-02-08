import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1

RowLayout {
  property TextField textField: textField
  property bool loadingValue: false
  id: stringEditor
  function textForValue() {
    return modelData.value;
  }
  Label {
    text: qsTranslate('config-strings', modelData.label)
  }
  TextField {
    id: textField
    placeholderText: modelData.defaultValue
    Layout.fillWidth: true
    onTextChanged: {
      if(!stringEditor.loadingValue) {
        modelData.value = text;
      }
    }
  }
  Connections {
    target: configEditor
    onConfigurationChanged: {
      stringEditor.loadingValue = true;
      textField.text = textForValue()
      stringEditor.loadingValue = false;
    }
  }
}

