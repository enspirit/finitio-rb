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
  # Accordingly, the `from_q` transformation function has the signature below.
  # It expects it's Alpha/Object argument to be a object responding to
  # `each` (with the ruby idiomatic semantics that such a `each` returns
  # an Enumerator when invoked without block).
  #
  #     from_q :: Alpha  -> Adresses     throws TypeError
  #     from_q :: Object -> Set[String]  throws UpError
  #
  class SetType < Type
    include CollectionType

    # Apply the element type's `from_q` transformation to each element of
    # `value` (expected to respond to `each`). Return converted values in a
    # ruby Set.
    def from_q(value, handler = UpHandler.new)
      handler.failed!(self, value) unless value.respond_to?(:each)

      set = Set.new
      handler.iterate(value) do |elm, index|
        elm = elm_type.from_q(elm, handler)
        handler.fail!("Duplicate value `#{elm}`") if set.include?(elm)
        set << elm
      end
      set
    end

    def default_name
      "{#{elm_type.name}}"
    end

  end # class SetType
end # module Qrb
