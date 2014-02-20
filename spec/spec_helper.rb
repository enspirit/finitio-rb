$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'qrb'

module SpecHelpers

  def intType
    Qrb::BuiltinType.new(Integer, "intType")
  end

  def floatType
    Qrb::BuiltinType.new(Float, "floatType")
  end

end

class Foo
  def initialize(*args)
    @args = args
  end
  attr_reader :args
end

class Bar
  def initialize(*args)
    @args = args
  end
  attr_reader :args
end

RSpec.configure do |c|
  c.include SpecHelpers
end
