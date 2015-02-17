import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1

Loader {
  source: 'enum-editor.qml'
  Component.onCompleted: {
    item.choices = ['on', 'off', 'none'];
  }
}

