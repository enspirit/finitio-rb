module Finitio
  module HeadingBasedType

    def initialize(heading, name = nil, metadata = nil)
      unless heading.is_a?(Heading)
        raise ArgumentError, "Heading expected, got `#{heading}`"
      end

      super(name, metadata)
      @heading = heading
    end
    attr_reader :heading

    def [](attrname)
      heading.fetch(attrname)
    end

    def suppremum(other, simple_class, multi_class)
      return self if self == other
      return super(other) unless other.is_a?(simple_class) or other.is_a?(multi_class)
      return super(other) unless heading.looks_similar?(other.heading)
      result_heading = heading.suppremum(other.heading)
      builder = result_heading.multi? ? multi_class : simple_class
      builder.new(result_heading)
    end

    def ==(other)
      super || (other.is_a?(self.class) && heading == other.heading)
    end
    alias :eql? :==

    def hash
      self.class.hash ^ heading.hash
    end

    def resolve_proxies(system)
      self.class.new(heading.resolve_proxies(system), name, metadata)
    end

    def unconstrained
      self.class.new(heading.unconstrained, name, metadata)
    end

  end # module HeadingBasedType
end # module Finitio
