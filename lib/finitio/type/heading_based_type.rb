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

    def ==(other)
      super || (other.is_a?(self.class) && heading == other.heading)
    end
    alias :eql? :==

    def hash
      self.class.hash ^ heading.hash
    end

  end # module HeadingBasedType
end # module Finitio
