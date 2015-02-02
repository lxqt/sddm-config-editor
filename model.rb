require 'qml'
require_relative 'example-config-parser'

module SDDMConfigurationEditor
  module Model
    def self.create
      config_schema = ExampleConfigParser.new.parse(File.read('data/example.conf'))

      # Replace the plain arrays of settings with ArrayModels
      config_schema.each do |section|
        settings = section[:settings]
        settings_model = QML::Data::ArrayModel.new(*settings.first.keys)
        settings_model.replace(settings)
        section[:settings] = settings_model
      end

      model = QML::Data::ArrayModel.new(:section, :settings)
      model.replace(config_schema)
      model
    end
  end
end

