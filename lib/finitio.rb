require 'set'
require 'time'

module Finitio

  DSL_METHODS = [
    :attribute,
    :heading,
    :constraints,
    :any,
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

  require_relative "finitio/version"
  require_relative "finitio/errors"
  require_relative "finitio/support"
  require_relative 'finitio/type'
  require_relative 'finitio/data_type'
  require_relative 'finitio/system'

  DEFAULT_FACTORY = TypeFactory.new

  IDENTITY = ->(object){ object }

  DSL_METHODS.each do |meth|
    define_method(meth) do |*args, &bl|
      DEFAULT_FACTORY.public_send(meth, *args, &bl)
    end
  end

  def parse(source)
    require "finitio/syntax"
    Syntax.compile(source)
  end

  def ast(source)
    require "finitio/syntax"
    Syntax.ast(source)
  end

  def system(identifier)
    f = File.expand_path("../finitio/#{identifier}.fio", __FILE__)
    if File.exists?(f)
      parse(File.read(f))
    else
      raise Error, "Unknown system #{identifier}"
    end
  end

  def definition_files(of)
    dir = File.expand_path("../finitio/#{of}", __FILE__)
    Dir.glob("#{dir}/*.fio")
  end

  extend self

  DEFAULT_SYSTEM = system('Finitio/default')
end # module Finitio
