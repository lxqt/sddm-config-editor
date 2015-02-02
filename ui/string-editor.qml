import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1

RowLayout {
  Label {
    text: label
  }
  TextField {
    placeholderText: default_value
    text: typeof(value) === 'undefined' ? '' : value
    Layout.fillWidth: true
  }
}
