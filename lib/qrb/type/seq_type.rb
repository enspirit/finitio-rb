module Qrb
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
  # Accordingly, the `up` transformation function has the signature below.
  # It expects it's Alpha/Object argument to be a object responding to
  # `each` (with the ruby idiomatic semantics that such a `each` returns
  # an Enumerator when invoked without block).
  #
  #     up :: Alpha  -> Measures      throws TypeError
  #     up :: Object -> Array[Float]  throws UpError
  #
  class SeqType < Type

    def initialize(elm_type, name = nil)
      unless elm_type.is_a?(Type)
        raise ArgumentError, "Qrb::Type expected, got `#{elm_type}`"
      end

      super(name)
      @elm_type = elm_type
    end
    attr_reader :elm_type

    # Apply the element type's up transformation to each element of `value`
    # (expected to respond to `each`). Return converted values in a ruby
    # Array.
    def up(value, handler = UpHandler.new)
      handler.failed!(self, value) unless value.respond_to?(:each)

      value.each.each_with_index.map do |elm, index|
        handler.deeper(index) do
          elm_type.up(elm, handler)
        end
      end
    end

    def default_name
      "[#{elm_type.name}]"
    end

    def ==(other)
      return false unless other.is_a?(SeqType)
      elm_type == other.elm_type
    end
    alias :eql? :==

    def hash
      self.class.hash ^ self.elm_type.hash
    end

  end # class SeqType
end # module Qrb
