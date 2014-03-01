require 'set'

#
# Q - in Ruby
#
module Qrb

  DSL_METHODS = [
    :attribute,
    :heading,
    :constraints,
    :builtin,
    :adt,
    :subtype,
    :union,
    :seq,
    :set,
    :tuple,
    :relation,
    :type
  ]

  require_relative "qrb/version"
  require_relative "qrb/errors"
  require_relative "qrb/support"
  require_relative 'qrb/type'
  require_relative 'qrb/data_type'
  require_relative 'qrb/system'

  DEFAULT_FACTORY = TypeFactory.new

  IDENTITY = ->(object){ object }

  DSL_METHODS.each do |meth|
    define_method(meth) do |*args, &bl|
      DEFAULT_FACTORY.public_send(meth, *args, &bl)
    end
  end

  def parse(source)
    require "qrb/syntax"
    Syntax.compile(source)
  end

  def system(identifier)
    f = File.expand_path("../qrb/#{identifier}.q", __FILE__)
    if File.exists?(f)
      parse(File.read(f))
    else
      raise Error, "Unknown system #{identifier}"
    end
  end

  def definition_files(of)
    dir = File.expand_path("../qrb/#{of}", __FILE__)
    Dir.glob("#{dir}/*.q")
  end

  extend self

  DEFAULT_SYSTEM = system('Q/default')
end # module Qrb
