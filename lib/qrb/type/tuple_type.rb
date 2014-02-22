module Qrb
  #
  # The Tuple type generator allows capturing information *facts*. For
  # instance, a Point type could be defined as follows:
  #
  #     Point = {r: Length, theta: Angle}
  #
  # This class allows capturing those information types, as in:
  #
  #     Length = BuiltinType.new(Fixnum)
  #     Angle  = BuiltinType.new(Float)
  #     Point  = TupleType.new(Heading.new([
  #                Attribute.new(:r, Length),
  #                Attribute.new(:theta, Angle)
  #              ]))
  #
  # A Hash with Symbol as keys is used as concrete ruby representation for
  # tuples. The values map to the concrete representations of each attribute
  # type:
  #
  #     R(Point) = Hash[r: R(Length), theta: R(Angle)]
  #              = Hash[r: Fixnum, theta: Float]
  #
  # Accordingly, the `from_q` transformation function has the signature below.
  # It expects it's Alpha/Object argument to be a Hash with all and only the
  # expected keys (either as Symbols or Strings). The `from_q` function
  # applies on every attribute value according to their respective type.
  #
  #     from_q :: Alpha  -> Point                         throws TypeError
  #     from_q :: Object -> Hash[r: Fixnum, theta: Float] throws UpError
  #
  class TupleType < Type

    def initialize(heading, name = nil)
      unless heading.is_a?(Heading)
        raise ArgumentError, "Heading expected, got `#{heading}`"
      end

      super(name)
      @heading = heading
    end
    attr_reader :heading

    # Convert `value` (supposed to be Hash) to a Tuple, by checking attributes
    # and applying `from_q` on them in turn. Raise an error if any attribute
    # is missing or unrecognized, as well as if any sub transformation fails.
    def from_q(value, handler = UpHandler.new)
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
          uped[attribute.name] = attribute.type.from_q(val, handler)
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
