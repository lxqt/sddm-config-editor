import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1

RowLayout {
  Label {
    text: label
  }
  TextField {
    placeholderText: default_value
    Layout.fillWidth: true
  }
}
