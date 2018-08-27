import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.3

RowLayout {
    Layout.fillWidth: true
  property ComboBox comboBox: comboBox
  property var choices: []
  Label {
    text: qsTranslate('config-strings', modelData.label)
  }
  ComboBox {
    id: comboBox
    editable: true
    Layout.fillWidth: true
    model: [''].concat(choices)
    // Emulate placeholder text
    Label {
      anchors.left: parent.left
      anchors.margins: 5
      anchors.baseline: parent.baseline
      text: modelData.defaultValue
      opacity: modelData.value === '' && comboBox.editText === '' ? 1 : 0
      color: 'gray'
    }
    onActivated: {
      this.currentIndex = index;
      if(index > 0) {
        modelData.value = currentText;
      } else {
        modelData.value = '';
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
        comboBox.currentIndex = 0;
        comboBox.editText = '';
      }
    }
  }
}

