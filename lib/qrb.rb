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
  require_relative 'qrb/realm'

  DEFAULT_FACTORY = TypeFactory.new

  IDENTITY = ->(object){ object }

  module Dsl

    DSL_METHODS.each do |meth|
      define_method(meth) do |*args, &bl|
        DEFAULT_FACTORY.public_send(meth, *args, &bl)
      end
    end

    def parse_realm(source)
      require "qrb/syntax"
      Syntax.compile_realm(source)
    end

    def parse_type(source)
      require "qrb/syntax"
      Syntax.compile_type(source)
    end

    def parse_schema(source)
      require "qrb/syntax"
      Syntax.compile_schema(source)
    end

  end
  extend Dsl

end # module Qrb
