module Finitio
  #
  # A sub type generator, through specialization by constraints.
  #
  # A sub type captures a subset of the values of a super type, through a
  # constraint. For instance, a Byte type can be defined as a subset of all
  # integers, as follows:
  #
  #     Byte := Integer( i | i >= 0 and i <= 255 )
  #
  # This class allows defining such sub types with multiple named constraints.
  # For instance,
  #
  #     Int  = BuiltinType.new(Integer)
  #     Byte = SubType.new(Int, positive: ->(i){ i >= 0 },
  #                             small:    ->(i){ i <= 255 })
  #
  # The concrete representation of the super type is kept as representation
  # of the sub type. In other words:
  #
  #     R(Byte) = R(Int) = Fixnum
  #
  # Accordingly, the `dress` transformation function has the following signature:
  #
  #     dress :: Alpha  -> Byte   throws TypeError
  #     dress :: Object -> Fixnum throws TypeError
  #
  class SubType < Type

    DEFAULT_CONSTRAINT_NAMES = [:default, :predicate].freeze

    def initialize(super_type, constraints, name = nil)
      unless super_type.is_a?(Type)
        raise ArgumentError, "Finitio::Type expected, got #{super_type}"
      end

      unless constraints.is_a?(Hash)
        raise ArgumentError, "Hash expected for constraints, got #{constraints}"
      end

      super(name)
      @super_type, @constraints = super_type, constraints.freeze
    end
    attr_reader :super_type, :constraints

    def default_name
      constraints.keys.first.to_s.capitalize
    end

    def include?(value)
      super_type.include?(value) && constraints.all?{|_,c| c===value }
    end

    # Check that `value` can be uped through the supertype, then verify all
    # constraints. Raise an error if anything goes wrong.
    def dress(value, handler = DressHelper.new)
      # Check that the supertype is able to dress the value.
      # Rewrite and set cause to any encountered TypeError.
      uped = handler.try(self, value) do
        super_type.dress(value, handler)
      end

      # Check each constraint in turn
      constraints.each_pair do |name, constraint|
        next if constraint===uped
        msg = handler.default_error_message(self, value)
        msg << " (not #{name})" unless default_constraint?(name)
        handler.fail!(msg)
      end

      # seems good, return the uped value
      uped
    end

    def ==(other)
      return false unless other.is_a?(SubType)
      other.super_type == super_type and \
      set_equal?(constraints.values, other.constraints.values)
    end
    alias :eql? :==

    def hash
      self.class.hash ^ super_type.hash ^ set_hash(constraints.values)
    end

  private

    def default_constraint?(name)
      DEFAULT_CONSTRAINT_NAMES.include?(name) or \
        name.to_s.capitalize == self.name
    end

  end # class SubType
end # module Finitio
