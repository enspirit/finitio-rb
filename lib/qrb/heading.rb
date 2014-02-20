module Qrb
  class Heading
    include Enumerable

    def initialize(attributes)
      unless attributes.is_a?(Enumerable) and \
             attributes.all?{|a| a.is_a?(Attribute) }
        raise ArgumentError, "Enumerable[Attribute] expected"
      end

      @attributes = {}
      attributes.each do |attr|
        if @attributes[attr.name]
          raise ArgumentError, "Attribute names must be unique"
        end
        @attributes[attr.name] = attr
      end
      @attributes.freeze
    end

    def size
      @attributes.size
    end

    def each(&bl)
      return to_enum unless bl
      @attributes.values.each(&bl)
    end

    def ==(other)
      return nil unless other.is_a?(Heading)
      attributes == other.attributes
    end

    def hash
      attributes.hash
    end

    attr_reader :attributes
    protected   :attributes

  end # class Heading
end # class Qrb
