module Finitio
  #
  # The Struct type generator allows capturing positional sequences of values,
  # such as pairs, triples and so forth. For instance, a Point type could be
  # defined as follows:
  #
  #     Point = <Length, Angle>
  #
  # This class allows capturing those information types, as in:
  #
  #     Length = BuiltinType.new(Fixnum)
  #     Angle  = BuiltinType.new(Float)
  #     Point  = StructType.new([Length, Angle])
  #
  # A simple Array is used as concrete ruby representation for structs. The
  # values map to the concrete representations of each component type:
  #
  #     R(Point) = Array[R(Length) ^ R(Angle)]
  #              = Array[Fixnum ^ Float]
  #              = Array[Numeric]
  #
  # where `^` denotes the `least common super type` operator on ruby classes.
  #
  # Accordingly, the `dress` transformation function has the signature below.
  # It expects it's Alpha/Object argument to be an Array with all and only the
  # expected components. The `dress` function applies on every component
  # according to its type.
  #
  #     dress :: Alpha  -> Point          throws TypeError
  #     dress :: Object -> Array[Numeric] throws TypeError
  #
  class StructType < Type

    def initialize(component_types, name = nil, metadata = nil)
      unless component_types.is_a?(Array) &&
             component_types.all?{|c| c.is_a?(Type) }
        raise ArgumentError, "[Finitio::Type] expected, got `#{component_types}`"
      end

      super(name, metadata)
      @component_types = component_types
    end
    attr_reader :component_types

    def representator
      component_types.map(&:representator)
    end

    def default_name
      "<" + @component_types.map(&:name).join(', ') + ">"
    end

    def include?(value)
      value.is_a?(Array) &&
      value.size==component_types.size &&
      value.zip(component_types).all?{|v,t| t.include?(v) }
    end

    def dress(value, handler = DressHelper.new)
      handler.failed!(self, value) unless value.is_a?(Array)

      # check the size
      cs, vs = component_types.size, value.size
      handler.fail!("Struct size mismatch (#{vs} for #{cs})") unless cs==vs

      # dress components
      array = []
      handler.iterate(value) do |elm, index|
        array << component_types[index].dress(elm, handler)
      end
      array
    end

    def ==(other)
      super || (other.is_a?(StructType) && other.component_types == component_types)
    end
    alias :eql? :==

    def hash
      self.class.hash ^ component_types.hash
    end

    def resolve_proxies(system)
      StructType.new(component_types.map{|t| t.resolve_proxies(system)}, name, metadata)
    end

    def unconstrained
      StructType.new(component_types.map{|t| t.unconstrained}, name, metadata)
    end

  end # class StructType
end # module Finitio
