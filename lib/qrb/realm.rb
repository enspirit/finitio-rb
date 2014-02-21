module Qrb
  #
  # A Realm is a collection of named Q types.
  #
  class Realm

    def initialize
      @types = {}
    end

    [
      :builtin,
      :adt,
      :subtype,
      :union,
      :seq,
      :set,
      :tuple,
      :relation
    ].each do |dsl_method|
      define_method(dsl_method){|*args, &bl|
        builder.add_type builder.public_send(dsl_method, *args, &bl)
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

  private

    def builder
      @builder ||= RealmBuilder.new(self)
    end

  end # class Realm
end # module Qrb
