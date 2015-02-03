import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

RowLayout {
  CheckBox {
    id: checkBox
    text: modelData.label
    checkedState: {
      if(!modelData.isDefined()) {
        if(modelData.default_value) {
          return Qt.PartiallyChecked;
        } else {
          return Qt.Unchecked
        }
      } else {
        return modelData.value;
      }
    }
  }
  Binding {
    target: modelData
    property: 'value'
    value: {
      switch(checkBox.checkedState) {
        case(Qt.Checked): true; break;
        case(Qt.Unchecked): false; break;
        default: ''
      }
    }
  }
}
