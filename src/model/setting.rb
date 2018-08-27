require 'qml'
require_relative '../version'

module SDDMConfigurationEditor
  class Setting
    include QML::Access
    register_to_qml

    ATTRIBUTES = [:key, :value, :defaultValue, :label, :type, :description]
    ATTRIBUTES.each do |attribute|
      property(attribute) {instance_variable_get "@#{attribute}"}
    end

    def initialize(hash)
      populate(hash)
      super()
    end

    def [](name)
      send(name)
    end

    def populate(hash)
      ATTRIBUTES.each do |attribute|
        self.instance_variable_set "@#{attribute}", hash[attribute]
      end
    end

    def isDefined
      value && value != '' || value == false
    end
  end
end

