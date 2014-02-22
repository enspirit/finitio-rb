module Qrb
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
  # Accordingly, the from_q transformation function has the signature below.
  # It expects an Enumerable as input and fails if any duplicate is found
  # (after tuple transformation), or if any tuple fails at being transformed.
  #
  #     from_q :: Alpha  -> ColoredPoints   throws TypeError
  #     from_q :: Object -> Set[Hash[...]]  throws TypeError
  #
  class RelationType < Type

    def initialize(heading, name = nil)
      unless heading.is_a?(Heading)
        raise ArgumentError, "Heading expected, got `#{heading}`"
      end

      super(name)
      @heading = heading
    end
    attr_reader :heading

    # Apply the corresponding TupleType's `from_q` to every element of `value`
    # (any enumerable). Return a Set of transformed tuples. Fail if anything
    # goes wrong transforming tuples or if duplicates are found.
    def from_q(value, handler = FromQHelper.new)
      handler.failed!(self, value) unless value.respond_to?(:each)

      # Up every tuple and keep results in a Set
      set = Set.new
      handler.iterate(value) do |tuple, index|
        tuple = tuple_type.from_q(tuple, handler)
        handler.fail!("Duplicate tuple") if set.include?(tuple)
        set << tuple
      end

      # Return built tuples
      set
    end

    def default_name
      "{{#{heading.to_name}}}"
    end

    def ==(other)
      return false unless other.is_a?(RelationType)
      heading == other.heading
    end
    alias :eql? :==

    def hash
      self.class.hash ^ heading.hash
    end

  private

    def tuple_type
      @tuple_type ||= TupleType.new(heading)
    end

  end # class RelationType
end # module Qrb
