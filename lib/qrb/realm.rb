module Qrb
  #
  # A Realm is a collection of named Q types.
  #
  class Realm

    def initialize
      @types = {}
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

  end # class Realm
end # module Qrb
