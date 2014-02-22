module Qrb
  #
  # A BuiltinType generator allows capuring an information type to a type of
  # the host language, here a Ruby class. For instance,
  #
  #     Int := BuiltinType(ruby.Fixnum)
  #
  # The set of values captured by the information type is the same set of
  # values that can be represented by the host type. In the example, `Int`
  # captures the same set of numbers as ruby's Fixnum.
  #
  # The ruby class is used as concrete representation of the information type.
  # In the example:
  #
  #     R(Int) = Fixnum
  #
  # Accordingly, the `from_q` transformation function has the following signature:
  #
  #     from_q :: Alpha  -> Int    throws TypeError
  #     from_q :: Object -> Fixnum throws UpError
  #
  class BuiltinType < Type

    def initialize(ruby_type, name = nil)
      super(name)
      @ruby_type = ruby_type
    end
    attr_reader :ruby_type

    # Check that `value` is a valid instance of `ruby_type` through `===` or
    # raise an error.
    def from_q(value, handler = UpHandler.new)
      handler.failed!(self, value) unless ruby_type===value
      value
    end

    def default_name
      @ruby_type.name.to_s
    end

    def ==(other)
      return false unless other.is_a?(BuiltinType)
      other.ruby_type==ruby_type
    end
    alias :eql? :==

    def hash
      self.class.hash ^ ruby_type.hash
    end

  end # class BuiltinType
end # module Qrb
