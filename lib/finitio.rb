require 'set'
require 'time'
require 'pathname'
require 'thread'

module Finitio

  require_relative "finitio/version"
  require_relative "finitio/errors"
  require_relative "finitio/support"
  require_relative 'finitio/type'
  require_relative 'finitio/system'
  require_relative "finitio/syntax"

  IDENTITY = ->(object){ object }

  ANY_TYPE = AnyType.new

  LOCK = Mutex.new

  STDLIB_PATHS = [
    File.expand_path('../finitio/stdlib', __FILE__)
  ]

  MEMOIZED_SYSTEMS = {}

  def stdlib_path(path)
    LOCK.synchronize {
      STDLIB_PATHS << path
    }
  end

  def parse(source)
    Syntax.parse(source)
  end

  def system(source)
    LOCK.synchronize {
      _system(source)
    }
  end

  def _system(source)
    if expanded = is_stdlib_source?(source)
      MEMOIZED_SYSTEMS[expanded] ||= Syntax.compile(source)
    else
      Syntax.compile(source)
    end
  end
  private :_system

  def clear_saved_systems!
    LOCK.synchronize {
      MEMOIZED_SYSTEMS.clear
    }
  end

  def ast(source)
    Syntax.ast(source)
  end

  def is_stdlib_source?(source)
    return false unless source.respond_to?(:to_path)
    stdlib = STDLIB_PATHS.any?{|stdlib|
      a_list = File.expand_path(source.to_path).split('/')
      b_list = File.expand_path(stdlib).split('/')
      a_list[0..b_list.size-1] == b_list
    }
    stdlib ? File.expand_path(source.to_path) : nil
  end

  extend self

  DEFAULT_SYSTEM = system(File.read(
    File.expand_path('../finitio/stdlib/finitio/data.fio', __FILE__)
  ))
end # module Finitio
