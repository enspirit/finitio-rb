$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'qrb'
require 'qrb/syntax'

module SpecHelpers

  def intType
    Qrb::BuiltinType.new(Integer, "intType")
  end

  def floatType
    Qrb::BuiltinType.new(Float, "floatType")
  end

  def nilType
    Qrb::BuiltinType.new(NilClass, "nilType")
  end

  def byte
    Qrb::SubType.new(intType, byte: ->(i){ i>=0 && i<=255 })
  end

  def type_factory
    Qrb::TypeFactory.new
  end

end

class Color

  def initialize(r, g, b)
    @r, @g, @b = r, g, b
  end
  attr_reader :r, :g, :b

  def self.rgb(tuple)
    new(tuple[:r], tuple[:g], tuple[:b])
  end

  def to_rgb
    { r: @r, g: @g, b: @b }
  end

  def self.hex(s)
    Color.new *[1, 3, 5].map{|i| s[i, 2].to_i(16) }
  end

  def to_hex
    "#" << [r, g, b].map{|i| i.to_s(16) }.join
  end

end

RSpec.configure do |c|
  c.include SpecHelpers
end
