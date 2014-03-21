require 'set'
require 'time'

module Finitio

  require_relative "finitio/version"
  require_relative "finitio/errors"
  require_relative "finitio/support"
  require_relative 'finitio/type'
  require_relative 'finitio/system'

  IDENTITY = ->(object){ object }

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
