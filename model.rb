require 'qml'
require_relative 'config-schema'

module SDDMConfigurationEditor
  module Model
    def self.create
      model = QML::Data::ArrayModel.new(:section, :entries)
      CONFIG_SCHEMA.each do |section|
        section_name, entries = section.values_at(:section, :entries)
        entries_model = QML::Data::ArrayModel.new(*entries.first.keys)
        entries_model.replace(entries)
        model << {section: section_name,
                  entries: entries_model}
      end
      model
    end
  end
end

