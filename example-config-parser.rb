require 'parslet'
require_relative 'ini-parser'


class ExampleConfigTransform < Parslet::Transform
  rule(line: simple(:line)) {
    line.str.strip
  }

  rule(lines: sequence(:lines)) {
    lines
  }

  rule(comment: sequence(:_comment),
       key: simple(:_key),
       value: subtree(:_value)) {
    key = _key.str.strip
    value = _value == [] ? '' : _value.str.strip
    (type, default) =
      case value
      when /\d+/
        [:integer, Integer(value)]
      when /^true|false$/
        [:boolean, value == true]
      when %r(^/[^:]+:)
        [:path_list, value]
      when %r(^/)
        [/(?:Path|Dir)$/ === key ? :directory : :file, value]
      when []
        [:string, '']
      else
        [:string, value]
      end
    {label: _comment && _comment.first || '',
     description: _comment && _comment[1] && _comment[1..-1].join("\n") || '',
     key: key, type: type, default_value: default}
  }

  rule(comment: subtree(:_comment),
       name: simple(:_name),
       entries: subtree(:_entries)) {
    {section: _name.str,
     entries: _entries}
  }

  rule(sections: subtree(:_sections)) {
    _sections
  }
end

class ExampleConfigParser
  def initialize
    @parser = INIParser.new
    @transform = ExampleConfigTransform.new
  end

  def parse(text, *options)
    @transform.apply @parser.parse(text, *options)
  end
end

