import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

CheckBox {
  text: modelData.label
  checkedState: {
    if(typeof(modelData.value) === 'undefined') {
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
