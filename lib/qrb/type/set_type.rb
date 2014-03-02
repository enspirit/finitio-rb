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
  # Accordingly, the `dress` transformation function has the signature below.
  # It expects it's Alpha/Object argument to be a object responding to
  # `each` (with the ruby idiomatic semantics that such a `each` returns
  # an Enumerator when invoked without block).
  #
  #     dress :: Alpha  -> Adresses     throws TypeError
  #     dress :: Object -> Set[String]  throws TypeError
  #
  class SetType < Type
    include CollectionType

    def default_name
      "{#{elm_type.name}}"
    end

    def include?(value)
      value.is_a?(::Set) and value.all?{|v| elm_type.include?(v) }
    end

    # Apply the element type's `dress` transformation to each element of
    # `value` (expected to respond to `each`). Return converted values in a
    # ruby Set.
    def dress(value, handler = DressHelper.new)
      handler.failed!(self, value) unless value.respond_to?(:each)

      set = Set.new
      handler.iterate(value) do |elm, index|
        elm = elm_type.dress(elm, handler)
        handler.fail!("Duplicate value `#{elm}`") if set.include?(elm)
        set << elm
      end
      set
    end

  end # class SetType
end # module Qrb
