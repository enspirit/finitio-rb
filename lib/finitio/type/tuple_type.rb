module Finitio
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
  # Accordingly, the `dress` transformation function has the signature below.
  # It expects it's Alpha/Object argument to be a Hash with all and only the
  # expected keys (either as Symbols or Strings). The `dress` function
  # applies on every attribute value according to their respective type.
  #
  #     dress :: Alpha  -> Point                         throws TypeError
  #     dress :: Object -> Hash[r: Fixnum, theta: Float] throws TypeError
  #
  class TupleType < Type
    include HeadingBasedType
    include HashBasedType

    def initialize(heading, name = nil, metadata = nil)
      super
      if heading.multi?
        raise ArgumentError, "Multi heading forbidden"
      end
    end

    def default_name
      "{#{heading.to_name}}"
    end

    def suppremum(other)
      super(other, TupleType, MultiTupleType)
    end

  end # class TupleType
end # module Finitio
