module Qrb
  class TupleType < Type

    def initialize(heading, name = nil)
      unless heading.is_a?(Heading)
        raise ArgumentError, "Heading expected, got `#{heading}`"
      end

      super(name)
      @heading = heading
    end
    attr_reader :heading

    def up(value, handler = UpHandler.new)
      handler.failed!(self, value) unless value.is_a?(Hash)

      # Uped values, i.e. tuple under construction
      uped = {}

      # Check the tuple arity and fail fast if extra attributes
      # (missing attributes are handled just after)
      if value.size > heading.size
        extra = value.keys.map(&:to_s) - heading.map{|attr| attr.name.to_s }
        handler.fail!("Unrecognized attribute `#{extra.first}`")
      end

      # Up each attribute in turn now. Fail on missing ones.
      heading.each do |attribute|
        val = attribute.fetch_on(value) do
          handler.fail!("Missing attribute `#{attribute.name}`")
        end
        handler.deeper(attribute.name) do
          uped[attribute.name] = attribute.type.up(val, handler)
        end
      end

      uped
    end

    def default_name
      "{#{heading.to_name}}"
    end

    def ==(other)
      return false unless other.is_a?(TupleType)
      heading == other.heading
    end
    alias :eql? :==

    def hash
      self.class.hash ^ heading.hash
    end

  end # class TupleType
end # module Qrb
