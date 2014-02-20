require 'set'
module Qrb
  class RelationType < Type

    def initialize(heading, name = nil)
      unless heading.is_a?(Heading)
        raise ArgumentError, "Heading expected, got `#{heading}`"
      end

      super(name)
      @heading = heading
    end
    attr_reader :heading

    def up(value, handler = UpHandler.new)
      handler.failed!(self, value) unless value.respond_to?(:each)

      # Up every tuple and keep results in a Set
      set = Set.new
      value.each.each_with_index do |tuple, index|
        handler.deeper(index) do
          tuple = tuple_type.up(tuple, handler)
          handler.fail!("Duplicate tuple") if set.include?(tuple)
          set << tuple
        end
      end

      # Return built tuples
      set
    end

    def default_name
      "{{#{heading.to_name}}}"
    end

    def ==(other)
      return false unless other.is_a?(RelationType)
      heading == other.heading
    end
    alias :eql? :==

    def hash
      self.class.hash ^ heading.hash
    end

  private

    def tuple_type
      @tuple_type ||= TupleType.new(heading)
    end

  end # class RelationType
end # module Qrb
