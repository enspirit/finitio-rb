module Finitio
  class AliasType

    def to_typescript(*args, &bl)
      target.ts_name || target.to_typescript
    end

  end # class AliasType
end # module Finitio
