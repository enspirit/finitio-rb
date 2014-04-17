module Finitio
  #
  # Helper class for tuple and relation attributes.
  #
  # An attribute is simply a `(name: AttrName, type: Type)` pair, where the
  # type is a Finitio type.
  #
  class Attribute
    include Metadata

    def initialize(name, type, required = true, metadata = nil)
      unless name.is_a?(Symbol)
        raise ArgumentError, "Symbol expected for attribute name, got `#{name}`"
      end

      unless type.is_a?(Type)
        raise ArgumentError, "Type expected for attribute domain, got `#{type}`"
      end

      @name, @type, @required, @metadata = name, type, required, metadata
    end
    attr_reader :name, :type, :required
    alias :required? :required

    def optional?
      !required?
    end

    # Fetch the attribute on `arg`, which is expected to be a Hash object.
    #
    # This method allows working with ruby hashes having either Symbols or
    # Strings as keys. It ensures that no Symbol is created by the rest of the
    # code, since this would provide a DoS attack vector under MRI.
    #
    def fetch_on(arg, &bl)
      unless arg.respond_to?(:fetch)
        raise ArgumentError, "Object responding to `fetch` expected"
      end
      arg.fetch(name) do
        arg.fetch(name.to_s, &bl)
      end
    end

    def to_name
      required ? "#{name}: #{type}" : "#{name} :? #{type}"
    end

    def ==(other)
      other.is_a?(Attribute) && name==other.name && \
      type==other.type && required==other.required
    end
    alias :eql? :==

    def hash
      name.hash ^ type.hash ^ required.hash
    end

  end # class Attribute
end # module Finitio
