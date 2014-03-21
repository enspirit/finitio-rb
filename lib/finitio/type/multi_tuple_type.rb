module Finitio
  #
  # The MultiTuple type generator allows capturing information *facts* with
  # optional attributes. For instance, a Point type with an optional color
  # could be defined as follows:
  #
  #     Point = { r: Length, theta: Angle, color :? Color }
  #
  # This class allows capturing those information types. Note that it is
  # actually syntactic sugar over union types:
  #
  #     Point = { r: Length, theta: Angle }
  #           | { r: Length, theta: Angle, color: Color }
  #
  # A Hash with Symbol as keys is used as concrete ruby representation for
  # multi tuples. The values map to the concrete representations of each
  # attribute type. The dress function is similar to the one of TupleType
  # but allows optional attributes to be omitted
  #
  class MultiTupleType < Type
    include HeadingBasedType
    include HashBasedType

    def default_name
      "{#{heading.to_name}}"
    end

  end # class MultiTupleType
end # module Finitio
