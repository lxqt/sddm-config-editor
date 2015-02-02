require 'qml'
require_relative 'version'
require_relative 'model'

module SDDMConfigurationEditor
  class ConfigEditorController
    include QML::Access
    register_to_qml

    property :model, Model.create
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

