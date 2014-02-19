module Qrb
  class Attribute

    def initialize(name, type)
      unless name.is_a?(Symbol)
        raise ArgumentError, "Symbol expected for attribute name, got `#{name}`"
      end

      unless type.is_a?(Type)
        raise ArgumentError, "Type expected for attribute domain, got `#{type}`"
      end

      @name, @type = name, type
    end
    attr_reader :name, :type

    def fetch_on(arg, &bl)
      unless arg.respond_to?(:fetch)
        raise ArgumentError, "Object responding to `fetch` expected"
      end
      arg.fetch(name) do
        arg.fetch(name.to_s, &bl)
      end
    end

    def ==(other)
      return nil unless other.is_a?(Attribute)
      name==other.name and type==other.type
    end
    alias :eql? :==

    def hash
      name.hash + 37*type.hash
    end

  end # class Attribute
end # module Qrb
