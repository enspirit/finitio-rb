module Finitio
  #
  # A System is a collection of named Finitio types.
  #
  class System

    def initialize(types = {}, imports = [])
      @types = types
      @imports = imports
    end

    attr_reader :types, :imports
    private :imports

    def add_import(system)
      @imports << system
    end

    def add_type(type, name = nil, metadata = nil)
      type = factory.type(type, name, metadata)

      if @types.has_key?(type.name)
        raise Error, "Duplicate type name `#{type.name}`"
      end

      @types[type.name] = type
    end

    def each_type(&bl)
      @types.values.each(&bl)
    end
    private :each_type

    def each_import(&bl)
      @imports.each(&bl)
    end
    private :each_import

    def get_type(name)
      fetch(name){|_|
        fetch(name.to_s){ nil }
      }
    end
    alias :[] :get_type

    def main
      self['Main']
    end

    def fetch(name, with_imports = true, &bl)
      if with_imports
        @types.fetch(name) do
          fetch_on_imports(name, &bl)
        end
      else
        @types.fetch(name, &bl)
      end
    end

    def fetch_on_imports(name, imports = @imports, &bl)
      if imports.empty?
        raise KeyError, %Q{key not found: "#{name}"} unless bl
        bl.call(name)
      else
        imports.first.fetch(name, false) do
          fetch_on_imports(name, imports[1..-1], &bl)
        end
      end
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

    def resolve_proxies
      scope = ProxyResolutionScope.new(self)
      types.each_key do |name|
        scope.fetch(name)
      end
      System.new(scope.built, imports)
    end

    def inspect
      @types.each_pair.map{|k,v| "#{k} = #{v}" }.join("\n")
    end

    def dup
      System.new(@types.dup, @imports.dup)
    end

    def check_and_warn(logger = nil)
      logger ||= begin
        require 'logger'
        Logger.new(STDERR)
      end
      each_type do |t|
        next unless t.named?
        each_import do |i|
          next unless found = i.get_type(t.name)
          if found == t
            logger.info "Duplicate type def `#{t.name}`"
            break
          else
            logger.warn "Type erasure `#{t.name}`"
            break
          end
        end
      end
      self
    end

  end # class System
end # module Finitio
