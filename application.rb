require 'qml'
require_relative 'version'
require_relative 'model/configuration'
require 'tempfile'

module SDDMConfigurationEditor
  class ConfigEditorController
    include QML::Access
    register_to_qml

    property(:model) {@configuration.model}

    def initialize
      @configuration = Configuration.new
      super
    end

    def self.load_config
      File.read('/etc/sddm.conf')
    end
    property :config_text, load_config

    def load
      self.config_text = self.class.load_config
      parse(config_text)
    end

    def save
      file = Tempfile.new('sddm-config-editor')
      file.write config_text
      file.close
      spawn 'pkexec', 'cp', file.path, '/etc/sddm.conf'
    end

    def parse(text)
      @configuration.parse_values(text)
    end

    def generate
      self.config_text = @configuration.generate_file()
    end
  end
end

QML.run do |app|
  app.load_path 'ui/main-window.qml'
end

