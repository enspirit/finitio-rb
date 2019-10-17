$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'path'
require 'finitio'
require 'finitio/syntax'

require 'coveralls'
Coveralls.wear!

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

  def ==(other)
    other.is_a?(Color) and other.to_rgb == self.to_rgb
  end

end

module ExternalContract
  def self.dress(x)
  end
  def self.undress(y)
  end
end

module SpecHelpers

  def anyType
    Finitio::AnyType.new
  end

  def intType
    @intType ||= Finitio::BuiltinType.new(Integer, "intType")
  end

  def floatType
    @floatType ||= Finitio::BuiltinType.new(Float, "floatType")
  end

  def nilType
    @nilType ||= Finitio::BuiltinType.new(NilClass, "nilType")
  end

  def trueType
    @trueType ||= Finitio::BuiltinType.new(TrueClass, "trueType")
  end

  def falseType
    @falseType ||= Finitio::BuiltinType.new(FalseClass, "falseType")
  end

  def stringType
    @stringType ||= Finitio::BuiltinType.new(String, "stringType")
  end

  def byte_full
    @byte_full ||= Finitio::Constraint.new(->(i){ i>=0 && i<=255 }, :byte)
  end

  def byte_min
    @byte_min ||= Finitio::Constraint.new(->(i){ i>=0 }, :byte_min)
  end

  def byte_max
    @byte_max ||= Finitio::Constraint.new(->(i){ i<=255 }, :byte_max)
  end

  def positive
    @positive ||= Finitio::Constraint.new(->(i){ i>=0 }, :positive)
  end

  def negative
    @negative ||= Finitio::Constraint.new(->(i){ i<0 }, :negative)
  end

  def byte
    @byte ||= Finitio::SubType.new(intType, [byte_full])
  end

  def pos_byte
    @pos_byte ||= Finitio::SubType.new(byte, [positive])
  end

  def posInt
    @posInt ||= Finitio::SubType.new(intType, [positive])
  end

  def negInt
    @negInt ||= Finitio::SubType.new(intType, [negative])
  end

  def type_factory
    Finitio::TypeFactory.new
  end

  def system
    Finitio::System.new
  end

  def blueviolet
    Color.new(138, 43, 226)
  end

  def rgb_contract
    @rgb_contract ||= Finitio::Contract.new(byte, Color.method(:rgb), Finitio::IDENTITY, :rgb)
  end

  def hex_contract
    @hex_contract ||= Finitio::Contract.new(floatType, Color.method(:hex), Finitio::IDENTITY, :hex)
  end

end

RSpec.configure do |c|
  c.include SpecHelpers
end
