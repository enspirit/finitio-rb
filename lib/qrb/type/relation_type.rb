require 'set'
module Qrb
  class RelationType < Type

    def initialize(name, heading)
      unless heading.is_a?(Heading)
        raise ArgumentError, "Heading expected, got `#{heading}`"
      end

      super(name)
      @heading = heading
    end
    attr_reader :heading

    def up(arg, handler = UpHandler.new)
      handler.branch(self, arg) do
        handler.fail! unless arg.respond_to?(:each)

        # Up every tuple and keep results in a Set
        set = Set.new
        arg.each.each_with_index do |tuple, index|
          tuple = tuple_type.up(tuple, handler)
          handler.fail!(message: "Duplicate tuple") if set.include?(tuple)
          set << tuple
        end

        # Return built tuples
        set
      end
    end

    def ==(other)
      return nil unless other.is_a?(RelationType)
      heading == other.heading
    end
    alias :eql? :==

    def hash
      heading.hash
    end

  private

    def tuple_type
      @tuple_type ||= TupleType.new(name, heading)
    end

  end # class RelationType
end # module Qrb
