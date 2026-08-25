module Finitio
  module RelBasedType

    def to_typescript(*args, &bl)
      "Set<#{tuple_type.to_typescript(*args, &bl)}>"
    end

  end # module RelBasedType
end # module Finitio
