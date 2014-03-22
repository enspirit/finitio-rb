module Finitio
  #
  # The MultiRelation type generator allows capturing sets of information
  # facts, but allowing optional attributes. E. g.,
  #
  #     ColoredPoints = {{ point: Point, color :? Color }}
  #
  # This class allows capturing those types, in a way similar to
  # MultiTupleType:
  #
  #     ColoredPoints = MultiRelationType.new( Heading[...] )
  #
  # A ruby Set is used as concrete representation, and will contain hashes
  # that are valid representations of the associated multi tuple type:
  #
  #     R(ColoredPoints) = Set[ R({...}) ] = Set[Hash[...]]
  #
  # Accordingly, the dress transformation function has the signature below.
  # It expects an Enumerable as input and fails if any duplicate is found
  # (after tuple transformation), or if any tuple fails at being transformed.
  #
  #     dress :: Alpha  -> ColoredPoints   throws TypeError
  #     dress :: Object -> Set[Hash[...]]  throws TypeError
  #
  class MultiRelationType < Type
    include HeadingBasedType
    include RelBasedType

    def default_name
      "{{#{heading.to_name}}}"
    end

  end # class MultiRelationType
end # module Finitio
