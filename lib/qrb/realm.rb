module Qrb
  #
  # A Realm is a collection of named Q types.
  #
  class Realm

    def initialize(types = {})
      @types = types
    end

    DSL_METHODS.each do |dsl_method|
      define_method(dsl_method){|*args, &bl|
        factory.public_send(dsl_method, *args, &bl)
      }
    end

    def add_type(type)
      unless type.is_a?(Type)
        raise ArgumentError, "Qrb::Type expected, got `#{type}`"
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

    def inspect
      @types.each_pair.map{|k,v| "#{k} = #{v}" }.join("\n")
    end

    def dup
      Realm.new(@types.dup)
    end

  end # class Realm
end # module Qrb
