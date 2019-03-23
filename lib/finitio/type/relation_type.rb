module Finitio
  #
  # The Relation type generator allows capturing sets of information facts,
  # i.e. sets of tuples (of same heading). E.g.
  #
  #     ColoredPoints = {{ point: Point, color: Color }}
  #
  # This class allows capturing relation types, in a way similar to TupleType:
  #
  #     ColoredPoints = RelationType.new( Heading[...] )
  #
  # A ruby Set is used as concrete representation, and will contain hashes
  # that are valid representations of the associated tuple type:
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
  class RelationType < Type
    include HeadingBasedType
    include RelBasedType

    def initialize(heading, name = nil, metadata = nil)
      super
      if heading.multi?
        raise ArgumentError, "Multi heading forbidden"
      end
    end

    def default_name
      "{{#{heading.to_name}}}"
    end

    def suppremum(other)
      super(other, RelationType, MultiRelationType)
    end

  end # class RelationType
end # module Finitio
