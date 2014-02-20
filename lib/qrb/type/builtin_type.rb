module Qrb
  #
  # A BuiltinType generator allows mapping an information type from Q to a
  # type of the host language, here Ruby. For instance,
  #
  #     Int := BuiltinType(ruby.Fixnum)
  #
  # The set of values captured by the information type is the same set of
  # values that can be represented by the host type. In the example, `Int`
  # captures the same set of numbers as ruby's Fixnum.
  #
  # Once uped, the representation of the information type is done through
  # the ruby class of the host type. In the example:
  #
  #    M(Int) = Fixnum
  #
  class BuiltinType < Type

    def initialize(ruby_type, name = nil)
      super(name)
      @ruby_type = ruby_type
    end
    attr_reader :ruby_type

    # Check that `value` is a valid instance of `ruby_type` through `===` or
    # raise an error.
    def up(value, handler = UpHandler.new)
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
