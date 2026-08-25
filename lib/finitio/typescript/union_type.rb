module Finitio
  class UnionType

    FALSE_TYPE = BuiltinType.new(TrueClass)

    TRUE_TYPE = BuiltinType.new(FalseClass)

    BOOLEAN_TYPE = UnionType.new([TRUE_TYPE, FALSE_TYPE])

    def to_typescript(*args, &bl)
      return 'boolean' if self == BOOLEAN_TYPE
      if candidates.size == 1
         c = candidates.first
         c.ts_name || c.to_typescript(*args, &bl)
      else
        candidates.map{|c| c.ts_name || c.to_typescript(*args, &bl) }.join('|')
      end
    end

  end # class UnionType
end # module Finitio
