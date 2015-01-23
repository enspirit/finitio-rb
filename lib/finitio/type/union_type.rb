require 'set'
module Finitio
  #
  # A union type (aka algebraic type) allows capturing information types
  # through generalization/disjunction. For instance,
  #
  #     Numeric = Int|Real
  #
  # This class allows capturing such union types, as follows:
  #
  #     Int     = BuiltinType.new(Fixnum)
  #     Real    = BuiltinType.new(Float)
  #     Numeric = UnionType.new([ Int, Real ])
  #
  # When transforming a value through `dress`, the different candidate types
  # are tried in specified order. The first one that succeeds at building the
  # value ends the process and the value is simply returned. Accordingly,
  # the concrete representation will be
  #
  #     R(Numeric) = R(Int) ^ R(Real) = Fixnum ^ Float = Numeric
  #
  # where `^` denotes the `least common super type` operator on ruby classes.
  #
  # Accordingly, the `dress` transformation function has the following
  # signature:
  #
  #     dress :: Alpha  -> Numeric throws TypeError
  #     dress :: Object -> Numeric throws TypeError
  #
  class UnionType < Type

    def initialize(candidates, name = nil, metadata = nil)
      unless candidates.all?{|c| c.is_a?(Type) }
        raise ArgumentError, "[Finitio::Type] expected, got #{candidates}"
      end

      super(name, metadata)
      @candidates = candidates.freeze
    end
    attr_reader :candidates

    def representator
      raise NotImplementedError
    end

    def include?(value)
      candidates.any?{|c| c.include?(value) }
    end

    # Invoke `dress` on each candidate type in turn. Return the value
    # returned by the first one that does not fail. Fail with an TypeError if no
    # candidate succeeds at tranforming `value`.
    def dress(value, handler = DressHelper.new)
      error = nil

      # Do nothing on TypeError as the next candidate could be the good one!
      candidates.each do |c|
        success, uped = handler.just_try do
          c.dress(value, handler)
        end
        return uped if success
        error ||= uped
      end

      # No one succeed, just fail
      handler.failed!(self, value, error)
    end

    def default_name
      candidates.map(&:name).join('|')
    end

    def ==(other)
      super || (
        other.is_a?(UnionType) && set_equal?(candidates, other.candidates)
      )
    end
    alias :eql? :==

    def hash
      self.class.hash ^ set_hash(self.candidates)
    end

  end # class UnionType
end # module Finitio
