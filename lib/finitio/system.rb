module Finitio
  #
  # A System is a collection of named Finitio types.
  #
  class System

    def initialize(types = {}, main = nil)
      @types = types
      @main  = main
    end
    attr_accessor :main

    def add_type(type)
      unless type.is_a?(Type)
        raise ArgumentError, "Finitio::Type expected, got `#{type}`"
      end

      if @types.has_key?(type.name)
        raise Error, "Duplicate type name `#{type.name}`"
      end

      @types[type.name] = type
    end

    def get_type(name)
      @types[name]
    end
    alias :[] :get_type

    def fetch(name, &bl)
      @types.fetch(name, &bl)
    end

    def factory
      @factory ||= TypeFactory.new
    end

    TypeFactory::DSL_METHODS.each do |dsl_method|
      define_method(dsl_method){|*args, &bl|
        factory.public_send(dsl_method, *args, &bl)
      }
    end

    def dress(*args, &bl)
      raise Error, "No main type." unless main
      main.dress(*args, &bl)
    end

    def parse(source)
      require_relative "syntax"
      Syntax.compile(source, self.dup)
    end

    def inspect
      @types.each_pair.map{|k,v| "#{k} = #{v}" }.join("\n")
    end

    def dup
      System.new(@types.dup, @main)
    end

  end # class System
end # module Finitio
