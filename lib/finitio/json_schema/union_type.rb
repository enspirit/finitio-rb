module Finitio
  class UnionType

    NIL_TYPE = BuiltinType.new(NilClass)

    FALSE_TYPE = BuiltinType.new(TrueClass)

    TRUE_TYPE = BuiltinType.new(FalseClass)

    BOOLEAN_TYPE = UnionType.new([TRUE_TYPE, FALSE_TYPE])

    def to_json_schema(*args, &bl)
      if type = metadata[:jsonSchemaType]
        return { type: type }
      end

      cs = candidates.reject{|c| c == NIL_TYPE }
      return { type: 'boolean'} if self == BOOLEAN_TYPE
      return cs.first.to_json_schema(*args, &bl) if cs.size == 1

      subtypes = cs.map{|c| c.to_json_schema(*args, &bl) }.uniq
      return subtypes.first if subtypes.size == 1
      {
        anyOf: subtypes
      }
    end

  end # class UnionType
end # module Finitio
