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
    onClicked: {
      switch(checkedState) {
        case(Qt.Checked):
          modelData.value = 'true';
          break;
        case(Qt.Unchecked):
          modelData.value = 'false';
          break;
        case(Qt.PartiallyChecked):
          modelData.value = '';
          break;
      }
    }
  }
  // Use a separate label instead of checkbox text so that label does not become
  // transparent when following default
  Label {
    id: label
    text: qsTranslate('config-strings', modelData.label)
    // QtQuick displays an empty gap after the checkbox indicator when the text
    // is empty. This hack tries to move the label to make it look like the checkbox
    // text
    Layout.fillWidth: true
  }
  Connections {
    target: configEditor
    onConfigurationChanged: checkBox.checkedState = checkedStateForValue()
  }
}
