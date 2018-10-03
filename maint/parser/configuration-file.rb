require 'parslet'
require_relative 'ini-file'
require_relative 'setting-conversion'

module SDDMConfigurationEditor
  class ConfigurationFileTransform < Parslet::Transform
    rule(line: simple(:line)) {
      line.str.strip
    }

    rule(lines: sequence(:lines)) {
      lines.join("\n")
    }

    rule(comment: simple(:_comment),
         key: simple(:_key),
         value: subtree(:_value)) {
      (_, key, value) = SettingConversion.convert(_key, _value)
      {comment: _comment,
       key: key,
       value: value}
    }

    rule(comment: subtree(:_comment),
         name: simple(:_name),
         settings: subtree(:_settings)) {
      {comment: _comment,
       name: _name.str,
       settings: _settings}
    }

    rule(sections: subtree(:_sections)) {
      _sections
    }
  end

  class ConfigurationFileParser
    def initialize
      @parser = INIParser.new
      @transform = ConfigurationFileTransform.new
    end

    def parse(text, *options)
      @transform.apply @parser.parse(text, *options)
    end
  end
end

