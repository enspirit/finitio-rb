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

  def intType
    Finitio::BuiltinType.new(Integer, "intType")
  end

  def floatType
    Finitio::BuiltinType.new(Float, "floatType")
  end

  def nilType
    Finitio::BuiltinType.new(NilClass, "nilType")
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

  def byte
    Finitio::SubType.new(intType, [byte_full])
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

end

RSpec.configure do |c|
  c.include SpecHelpers
end
