module Qrb
  #
  # The Set type generator allows capturing an unordered set of values (i.e.
  # with no duplicates). For example, a set of emails could be captured with:
  #
  #     Adresses = {Email}
  #
  # This class allows capturing those set types, e.g.:
  #
  #     Email    = BuiltinType.new(String)
  #     Adresses = SetType.new(Email)
  #
  # A ruby Set of values is used as concrete representation for such sets:
  #
  #     R(Adresses) = Set[R(Email)] = Set[String]
  #
  # Accordingly, the `up` transformation function has the signature below.
  # It expects it's Alpha/Object argument to be a object responding to
  # `each` (with the ruby idiomatic semantics that such a `each` returns
  # an Enumerator when invoked without block).
  #
  #     up :: Alpha  -> Adresses     throws TypeError
  #     up :: Object -> Set[String]  throws UpError
  #
  class SetType < Type

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
    # Set.
    def up(value, handler = UpHandler.new)
      handler.failed!(self, value) unless value.respond_to?(:each)

      set = Set.new
      value.each.each_with_index do |elm, index|
        handler.deeper(index) do
          elm = elm_type.up(elm, handler)
          handler.fail!("Duplicate value `#{elm}`") if set.include?(elm)
          set << elm
        end
      end
      set
    end

    def default_name
      "{#{elm_type.name}}"
    end

    def ==(other)
      return false unless other.is_a?(SetType)
      elm_type == other.elm_type
    end
    alias :eql? :==

    def hash
      self.class.hash ^ self.elm_type.hash
    end

  end # class SetType
end # module Qrb
