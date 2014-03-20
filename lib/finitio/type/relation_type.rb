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

    def initialize(heading, name = nil)
      unless heading.is_a?(Heading)
        raise ArgumentError, "Heading expected, got `#{heading}`"
      end

      super(name)
      @heading = heading
    end
    attr_reader :heading

    def default_name
      "{{#{heading.to_name}}}"
    end

    def include?(value)
      value.is_a?(Set) && value.all?{|tuple|
        tuple_type.include?(tuple)
      }
    end

    # Apply the corresponding TupleType's `dress` to every element of `value`
    # (any enumerable). Return a Set of transformed tuples. Fail if anything
    # goes wrong transforming tuples or if duplicates are found.
    def dress(value, handler = DressHelper.new)
      handler.failed!(self, value) unless value.respond_to?(:each)

      # Up every tuple and keep results in a Set
      set = Set.new
      handler.iterate(value) do |tuple, index|
        tuple = tuple_type.dress(tuple, handler)
        handler.fail!("Duplicate tuple") if set.include?(tuple)
        set << tuple
      end

      # Return built tuples
      set
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
end # module Finitio
