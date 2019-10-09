module Finitio
  module CollectionType

    def initialize(elm_type, name = nil, metadata = nil)
      unless elm_type.is_a?(Type)
        raise ArgumentError, "Finitio::Type expected, got `#{elm_type}`"
      end

      super(name, metadata)
      @elm_type = elm_type
    end
    attr_reader :elm_type

    def ==(other)
      super || (other.is_a?(self.class) && elm_type == other.elm_type)
    end
    alias :eql? :==

    def hash
      self.class.hash ^ self.elm_type.hash
    end

    def suppremum(other)
      return super unless other.is_a?(CollectionType)
      return self if other.is_a?(CollectionType) && elm_type == other.elm_type
      builder = self.class == other.class ? self.class : SeqType
      builder.new(elm_type.suppremum(other.elm_type))
    end

    def resolve_proxies(system)
      self.class.new(elm_type.resolve_proxies(system), name, metadata)
    end

  end # module CollectionType
end # module Finitio
