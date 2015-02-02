require 'parslet'
require_relative 'ini-parser'
require_relative 'setting-converter'

module SDDMConfigurationEditor
  class ConfigTransform < Parslet::Transform
    rule(line: simple(:line)) {
      line.str.strip
    }

    rule(lines: sequence(:lines)) {
      lines.join("\n")
    }

    rule(comment: simple(:_comment),
         key: simple(:_key),
         value: subtree(:_value)) {
      (_, key, value) = Setting.convert(_key, _value)
      {comment: _comment,
       key: key,
       value: value}
    }

    rule(comment: subtree(:_comment),
         name: simple(:_name),
         settings: subtree(:_settings)) {
      {comment: _comment,
       section: _name.str,
       settings: _settings}
    }

    rule(sections: subtree(:_sections)) {
      _sections
    }
  end

  class ConfigParser
    def initialize
      @parser = INIParser.new
      @transform = ConfigTransform.new
    end

    def parse(text, *options)
      @transform.apply @parser.parse(text, *options)
    end
  end

  if __FILE__ == $0
    require 'pp'
    pp ConfigParser.new.parse(File.read('/etc/sddm.conf'))
  end
end

