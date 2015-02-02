import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

CheckBox {
  text: label
  checkedState: default_value ? Qt.PartiallyChecked : Qt.Unchecked
}
