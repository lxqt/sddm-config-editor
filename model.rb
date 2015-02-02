require 'qml'
require_relative 'example-config-parser'

module SDDMConfigurationEditor
  module Model
    def self.create
      config_schema = ExampleConfigParser.new.parse(File.read('data/example.conf'))

      model = QML::Data::ArrayModel.new(:section, :entries)
      config_schema.each do |section|
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

