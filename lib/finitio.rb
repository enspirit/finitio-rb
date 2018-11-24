require 'set'
require 'time'
require 'pathname'

module Finitio

  require_relative "finitio/version"
  require_relative "finitio/errors"
  require_relative "finitio/support"
  require_relative 'finitio/type'
  require_relative 'finitio/system'

  IDENTITY = ->(object){ object }

  ANY_TYPE = AnyType.new

  STDLIB_PATHS = [
    File.expand_path('../finitio/stdlib', __FILE__)
  ]

  def stdlib_path(path)
    STDLIB_PATHS << path
  end

  def parse(source)
    require "finitio/syntax"
    Syntax.parse(source)
  end

  def system(source)
    require "finitio/syntax"
    Syntax.compile(source)
  end

  def ast(source)
    require "finitio/syntax"
    Syntax.ast(source)
  end

  extend self

  DEFAULT_SYSTEM = system(File.read(
    File.expand_path('../finitio/stdlib/finitio/data.fio', __FILE__)
  ))
end # module Finitio
