$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'qrb'

module SpecHelpers

  def intType
    Qrb::BuiltinType.new("intType", Integer)
  end

  def floatType
    Qrb::BuiltinType.new("floatType", Float)
  end

end

RSpec.configure do |c|
  c.include SpecHelpers
end
