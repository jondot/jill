$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'datafusion'

def fixture_content(file)
  File.read(fixture(file))
end

def fixture(file)
  File.expand_path("./fixtures/#{file}", File.dirname(__FILE__))
end

require 'minitest/autorun'
