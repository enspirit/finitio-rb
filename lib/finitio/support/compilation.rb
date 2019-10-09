module Finitio
  class Compilation

    def initialize(system = System.new, factory = TypeFactory.new, source = nil)
      @system  = system
      @factory = factory
      @source = source
    end
    attr_reader :system, :factory, :proxies, :source

    def self.coerce(arg, source = nil)
      case arg
      when NilClass    then new(System.new, TypeFactory.new, source)
      when System      then new(arg, arg.factory, source)
      when TypeFactory then new(System.new, arg, source)
      else
        raise ArgumentError, "Unable to coerce `#{arg}`"
      end
    end

    def imports
      @system.send(:imports)
    end

    def add_import(import)
      @system.add_import(import)
      self
    end

    def resolve_url(url)
      if url.to_s =~ /^\.\//
        resolve_relative_url(url)
      else
        STDLIB_PATHS.each do |path|
          file = File.expand_path("#{url}.fio", path)
          return Pathname.new(file) if File.file?(file)
        end
        raise Error, "No such import `#{url}`"
      end
    end

    def resolve_relative_url(url)
      raise Error, "Unable to resolve `#{url}`, missing path context"\
        unless source.respond_to?(:to_path)
      file = File.expand_path("../#{url}.fio", source.to_path)
      raise Error, "No such file `#{file}`" unless File.file?(file)
      Pathname.new(file)
    end

    def resolve_proxies
      system.resolve_proxies
    end

    # Delegation to Factory

    TypeFactory::DSL_METHODS.each do |dsl_method|
      define_method(dsl_method){|*args, &bl|
        factory.public_send(dsl_method, *args, &bl)
      }
    end

    # Delegation to System

    [
      :add_type,
      :fetch,
      :main,
    ].each do |meth|
      define_method(meth) do |*args, &bl|
        system.public_send(meth, *args, &bl)
      end
    end

  end # class Compilation
end # module Finitio
