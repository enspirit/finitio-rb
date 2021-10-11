module Finitio
  class UnionType

    NIL_TYPE = BuiltinType.new(NilClass)

    FALSE_TYPE = BuiltinType.new(TrueClass)

    TRUE_TYPE = BuiltinType.new(FalseClass)

    BOOLEAN_TYPE = UnionType.new([TRUE_TYPE, FALSE_TYPE])

    def to_json_schema(*args, &bl)
      cs = candidates.reject{|c| c == NIL_TYPE }
      return { type: 'boolean'} if self == BOOLEAN_TYPE
      return cs.first.to_json_schema(*args, &bl) if cs.size == 1

      {
        anyOf: cs.map{|c| c.to_json_schema(*args, &bl) }
      }
    end

  end # class UnionType
end # module Finitio
