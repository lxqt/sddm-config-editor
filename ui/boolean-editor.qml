import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

RowLayout {
  function checkedStateFromBoolean(value) {
    if(value === 'true') {
      return Qt.Checked;
    } else if(value === 'false') {
      return Qt.Unchecked;
    } else {
      return Qt.PartiallyChecked;
    }
  }
  function checkedStateForValue() {
    return checkedStateFromBoolean(modelData.value);
  }
  // Display a disabled checkbox indicating the default value
  CheckBox {
    anchors.left: parent.left
    id: defaultCheckBox
    enabled: false
    checkedState: checkedStateFromBoolean(modelData.defaultValue)
    // Set opacity to 0 when the setting is not following default
    opacity: {
      if(checkBox.checkedState === Qt.PartiallyChecked) {
        return 1;
      } else {
        return 0;
      }
    }
  }
  // Display a checkbox indicating the actual value over the default indicator
  CheckBox {
    anchors.left: parent.left
    // Cover the label so that clicking on it activates the checkbox
    anchors.right: label.right
    id: checkBox
    partiallyCheckedEnabled: true
    // Set opacity to 0 when the setting is following default
    opacity: {
      if(checkedState === Qt.PartiallyChecked) {
        return 0;
      } else {
        return 1;
      }
    }
  }
  // Use a separate label instead of checkbox text so that label does not become
  // transparent when following default
  Label {
    id: label
    text: modelData.label
    anchors.left: parent.left
    // QtQuick displays an empty gap after the checkbox indicator when the text
    // is empty. This hack tries to move the label to make it look like the checkbox
    // text
    anchors.leftMargin: 25
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
  Connections {
    target: configEditor
    onConfigurationChanged: checkBox.checkedState = checkedStateForValue()
  }
}
