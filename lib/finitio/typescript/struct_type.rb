module Finitio
  class StructType

    def to_typescript(*args, &bl)
      elms = component_types.map{|c| c.to_typescript(*args, &bl) }
      "[#{elms.join(', ')}]"
    end

  end # class StructType
end # module Finitio
