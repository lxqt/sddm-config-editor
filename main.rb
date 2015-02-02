require 'qml'
require_relative 'config-schema'
require_relative 'application'

QML.run do |app|
  app.load_path 'ui/main-window.qml'
end

