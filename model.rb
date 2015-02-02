require 'qml'
require_relative 'example-config-parser'

module SDDMConfigurationEditor
  module Model
    def self.create
      config_schema = ExampleConfigParser.new.parse(File.read('data/example.conf'))

      model = QML::Data::ArrayModel.new(:section, :settings)
      config_schema.each do |section|
        section_name, settings = section.values_at(:section, :settings)
        settings_model = QML::Data::ArrayModel.new(*settings.first.keys)
        settings_model.replace(settings)
        model << {section: section_name,
                  settings: settings_model}
      end
      model
    end
  end
end

