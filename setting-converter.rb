module SDDMConfigurationEditor
  module Setting
    def self.normalize_string(value)
      if value.respond_to? :str
        value = value.str
      elsif value == []
        value = ''
      end
      value.strip
    end

    def self.convert(key, value)
      key = normalize_string(key)
      value = normalize_string(value)

      case value
      when /\d+/
        [:integer, key, Integer(value)]
      when /^true|false$/
        [:boolean, key, value == 'true']
      when %r(^/[^:]+:)
        [:path_list, key, value]
      when %r(^/)
        [/(?:Path|Dir)$/ === key ? :directory : :file, key, value]
      when []
        [:string, key, '']
      else
        [:string, key, value]
      end
    end
  end
end

