$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'qrb'

module SpecHelpers

  def intType
    Qrb::BuiltinType.new(Integer, "intType")
  end

  def floatType
    Qrb::BuiltinType.new(Float, "floatType")
  end

  def byte
    Qrb::SubType.new(intType, byte: ->(i){ i>=0 && i<=255 })
  end

end

class Color
  def initialize(contract, rep)
    @contract = contract
    @rep = rep
  end
  attr_reader :contract, :rep
end

class RgbContract
  def self.rgb(rep)
    Color.new(:rgb, rep)
  end
end

class HexContract
  def self.hex(rep)
    Color.new(:hex, rep)
  end
end

RSpec.configure do |c|
  c.include SpecHelpers
end
