require 'qml'
require_relative 'version'
require_relative 'model'

module SDDMConfigurationEditor
  class ConfigEditorController
    include QML::Access
    register_to_qml

    property(:model) {Model.create}

    def self.load_config
      File.read('/etc/sddm.conf')
    end
    property :config_text, load_config

    def load
      self.config_text = self.class.load_config
    end

    def generate
      self.config_text = Model.generate_file(model)
    end
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

