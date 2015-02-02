require 'qml'
require_relative 'config-schema'

module SDDMConfigEditor
  VERSION = '0.1'
  class ConfigEditorController
    include QML::Access
    register_to_qml

    _model = QML::Data::ArrayModel.new(:section, :entries)
    CONFIG_SCHEMA.each do |section|
      section_name, entries = section.values_at(:section, :entries)
      entries_model = QML::Data::ArrayModel.new(*entries.first.keys)
      entries_model.replace(entries)
      _model << {section: section_name,
                 entries: entries_model}
    end
    property :model, _model
  end

  class ApplicationController
    include QML::Access
    register_to_qml

    def quit
      QML.application.quit
    end
  end
end

QML.run do |app|
  app.load_path 'ui/main-window.qml'
end

