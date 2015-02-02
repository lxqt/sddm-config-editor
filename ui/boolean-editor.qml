import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

CheckBox {
  text: label
  checkedState: {
    if(typeof(value) === 'undefined') {
      if(default_value) {
        return Qt.PartiallyChecked;
      } else {
        return Qt.Unchecked
      }
    } else {
      return value;
    }
  }
}
