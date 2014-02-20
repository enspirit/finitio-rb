require 'set'
module Qrb
  class RelationType < Type

    def initialize(name, heading)
      unless heading.is_a?(Heading)
        raise "Heading expected, got `#{heading}`"
      end

      super(name)
      @heading = heading
    end
    attr_reader :heading

    def up(arg)
      up_error!(arg) unless arg.respond_to?(:each)

      set = Set.new
      arg.each.each_with_index do |tuple, index|
        tuple = up_tuple(tuple, index)
        if set.include?(tuple)
          raise UpError.new("Duplicate tuple @ [#{index}]")
        end
        set << tuple
      end
      set
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

    def up_tuple(tuple, index)
      tuple_type.up(tuple)
    rescue UpError => cause
      msg = "Invalid tuple `#{tuple}` for #{to_s} @ [#{index}]"
      raise UpError.new(msg, cause)
    end

  end # class RelationType
end # module Qrb
