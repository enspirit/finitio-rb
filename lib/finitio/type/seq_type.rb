module Finitio
  #
  # The Seq type generator allows capturing sequences of values. For example,
  # a (implicitely temporal) series of temperature measures could be written
  # as:
  #
  #     Measures = [Temperature]
  #
  # This class allows capturing those sequence types, e.g.:
  #
  #     Temperature = BuiltinType.new(Float)
  #     Measures    = SeqType.new(Temperature)
  #
  # An array of values is used as concrete representation for such sequences:
  #
  #     R(Measures) = Array[R(Temperature)] = Array[Float]
  #
  # Accordingly, the `dress` transformation function has the signature below.
  # It expects it's Alpha/Object argument to be a object responding to
  # `each` (with the ruby idiomatic semantics that such a `each` returns
  # an Enumerator when invoked without block).
  #
  #     dress :: Alpha  -> Measures      throws TypeError
  #     dress :: Object -> Array[Float]  throws TypeError
  #
  class SeqType < Type
    include CollectionType

    def include?(value)
      value.is_a?(::Array) and value.all?{|v| elm_type.include?(v) }
    end

    # Apply the element type's `dress` transformation to each element of
    # `value` (expected to respond to `each`). Return converted values in a
    # ruby Array.
    def dress(value, handler = DressHelper.new)
      handler.failed!(self, value) unless value.respond_to?(:each)

      array = []
      handler.iterate(value) do |elm, index|
        array << elm_type.dress(elm, handler)
      end
      array
    end

    def default_name
      "[#{elm_type.name}]"
    end

  end # class SeqType
end # module Finitio
