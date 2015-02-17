import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.3

RowLayout {
    Layout.fillWidth: true
  property ComboBox comboBox: comboBox
  property var choices: []
  Label {
    text: modelData.label
  }
  ComboBox {
    id: comboBox
    editable: true
    Layout.fillWidth: true
    model: {
      choices.push('');
      return choices;
    }
    onActivated: {
      if(index === count - 1) {
        currentIndex = -1;
      }
    }
    // Emulate placeholder text
    Label {
      anchors.left: parent.left
      anchors.margins: 5
      anchors.baseline: parent.baseline
      text: modelData.defaultValue
      opacity: modelData.value === '' && comboBox.editText === '' ? 1 : 0
      color: 'gray'
    }
  }
  Binding {
    target: modelData
    property: 'value'
    value: {
      if(comboBox.currentIndex === comboBox.count - 1 || comboBox.currentIndex === -1) {
        return '';
      } else {
        return comboBox.currentText;
      }
    }
  }
  Connections {
    target: configEditor
    onConfigurationChanged: {
      if(modelData.isDefined()) {
        comboBox.currentIndex = comboBox.model.indexOf(modelData.value);
        comboBox.editText = comboBox.currentText;
      } else {
        comboBox.currentIndex = comboBox.count - 1;
        comboBox.editText = '';
      }
    }
  }
}

