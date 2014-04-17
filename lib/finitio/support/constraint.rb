module Finitio
  class Constraint
    include Metadata

    def initialize(native, name = nil, metadata = nil)
      unless native.respond_to?(:===)
        raise ArgumentError, "Constraint must respond to :==="
      end
      unless name.nil? or name.is_a?(Symbol)
        raise ArgumentError, "Constraint name must be a Symbol"
      end
      @native = native
      @name = name
      @metadata = metadata
    end

    attr_reader :native
    protected :native

    def anonymous?
      @name.nil?
    end

    def named?
      !anonymous?
    end

    def name
      @name || :default
    end

    def ===(*args, &bl)
      native.===(*args, &bl)
    end

    def ==(other)
      super || (other.is_a?(Constraint) && native==other.native)
    end
    alias :eql? :==

    def hash
      self.class.hash ^ native.hash
    end

  end # class Constraint
end # module Finitio
