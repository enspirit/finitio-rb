module Finitio
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
  # Accordingly, the `dress` transformation function has the following signature:
  #
  #     dress :: Alpha  -> Int    throws TypeError
  #     dress :: Object -> Fixnum throws TypeError
  #
  class BuiltinType < Type

    def initialize(ruby_type, name = nil, metadata = nil)
      super(name, metadata)
      @ruby_type = ruby_type
    end
    attr_reader :ruby_type

    def default_name
      @ruby_type.name.to_s
    end

    def include?(value)
      ruby_type === value
    end

    # Check that `value` is a valid instance of `ruby_type` through `===` or
    # raise an error.
    def dress(value, handler = DressHelper.new)
      handler.failed!(self, value) unless ruby_type===value
      value
    end

    def ==(other)
      super || (other.is_a?(BuiltinType) && other.ruby_type==ruby_type)
    end
    alias :eql? :==

    def hash
      self.class.hash ^ ruby_type.hash
    end

  end # class BuiltinType
end # module Finitio
