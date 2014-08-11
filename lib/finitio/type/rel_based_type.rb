module Finitio
  module RelBasedType

    def representator
      [tuple_type.representator]
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

  private

    def tuple_type
      @tuple_type ||= begin
        clazz = heading.multi? ? MultiTupleType : TupleType
        clazz.new(heading)
      end
    end

  end # module RelBasedType
end # module Finitio
