module Qrb
  class SubType < Type

    DEFAULT_CONSTRAINT_NAMES = [:default, :predicate].freeze

    def initialize(name, super_type, constraints)
      unless super_type.is_a?(Type)
        raise ArgumentError, "Qrb::Type expected, got #{super_type}"
      end

      unless constraints.is_a?(Hash)
        raise ArgumentError, "Hash expected for constraints, got #{constraints}"
      end

      super(name)
      @super_type, @constraints = super_type, constraints.freeze
    end
    attr_reader :super_type, :constraints

    def up(value)
      # try to up through the super type, re-causing any up error
      begin
        uped = super_type.up(value)
      rescue UpError => cause
        up_error!(value, cause)
      end

      # check each constraint in turn
      constraints.each_pair do |name, constraint|
        next if constraint===uped
        msg = up_error_message(value)
        msg += " (not #{name})" unless DEFAULT_CONSTRAINT_NAMES.include?(name)
        raise UpError, msg
      end

      # seems good, return the uped value
      uped
    end

    def ==(other)
      return nil unless other.is_a?(SubType)
      other.super_type == super_type and \
      set_equal?(constraints.values, other.constraints.values)
    end
    alias :eql? :==

    def hash
      super_type.hash + 37*set_hash(constraints.values)
    end

  end # class BuiltinType
end # module Qrb
