module Finitio
  #
  # An AnyType generator allows capuring the set of every ruby citizen as a
  # Finitio type.
  #
  #     Any := .
  #
  # Object is used as concrete representation of the information type as the
  # Ruby `Object` class already captures everything.
  #
  #     R(.) = Object
  #
  # Accordingly, the `dress` transformation function has the signature below.
  # Note that dress always succeeds and returns its first argument.
  #
  #     dress :: Alpha  -> Object throws TypeError
  #     dress :: Object -> Object throws TypeError
  #
  class AnyType < Type

    def initialize(name = nil, metadata = nil)
      super(name, metadata)
    end

    def default_name
      "Any"
    end

    def representator
      Object
    end

    def include?(value)
      true
    end

    def dress(value, handler = nil)
      value
    end

    def ==(other)
      super || other.is_a?(AnyType)
    end
    alias :eql? :==

    def hash
      self.class.hash ^ 37
    end

  end # class AnyType
end # module Finitio
