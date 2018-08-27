import QtQuick 2.2

Loader {
  source: 'string-editor.qml'
  Binding {
    target: item.textField
    property: 'validator'
    value: IntValidator {
      bottom: 0
    }
  }
}
