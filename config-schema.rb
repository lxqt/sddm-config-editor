require_relative 'example-config-parser'

CONFIG_SCHEMA = ExampleConfigParser.new.parse(File.read('data/example.conf'))

